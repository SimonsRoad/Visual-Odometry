#include <stdlib.h> 
#include <opencv2/core/core.hpp>
#include <string>       // std::string
#include <iostream>     // std::cout
#include <sstream>  
#include <highgui.h>
#include <opencv/cv.h>
#include <opencv2/contrib/contrib.hpp>
#include <opencv2/highgui/highgui.hpp>
#include "opencv2/opencv.hpp"
#include <fstream>

using namespace std;
using namespace cv;

string convertInt(int number)
{
	stringstream ss;	//create a stringstream
	ss << number;		//add number to the stream
	return ss.str();	//return a string with the contents of the stream
}

void get_correspondences(const Mat& frame1, const Mat& frame2, vector<Vec2f>& points1, vector<Vec2f>& points2)
{
	Ptr<StarFeatureDetector> detector = FeatureDetector::create("STAR");
	
	vector<KeyPoint> keypoints1, keypoints2;
	detector->detect(frame1, keypoints1);
	detector->detect(frame2, keypoints2);

	Ptr<BriefDescriptorExtractor> extractor = DescriptorExtractor::create("BRIEF");
	Mat descriptors1, descriptors2;
	extractor->compute(frame1, keypoints1, descriptors1);
	extractor->compute(frame2, keypoints2, descriptors2);

	Ptr<BFMatcher> matcher = DescriptorMatcher::create("BruteForce-Hamming");
	vector< vector<DMatch> > matches;
	matcher->knnMatch(descriptors1, descriptors2, matches, 2);
	for (uint i = 0; i < matches.size(); i++) {
		vector<DMatch>& neighbors = matches[i];
		if (neighbors.size() < 2) continue;
		if (neighbors[0].distance < neighbors[1].distance * 0.5) {
			points1.push_back(keypoints1[neighbors[0].queryIdx].pt);
			points2.push_back(keypoints2[neighbors[0].trainIdx].pt);
		}
	}
}

int graficarMov(){
	//Declaramos el comando requerido, lo dejamos en persist para modos ventana
	const char *cmd = "octave graficar.m";		//"octave -persist";//"gnuplot -persist";
	 
	//Abrimos el pipe para escribir en el
	FILE *pipe = popen(cmd,"w");
	 
	if(pipe == NULL){
		perror("No puedo encontrar octave.");
		return 0;
	}
	
	//Hacemos un flush a pipe para poder desplegar la ventana
	fflush(pipe);
	 
	//Cerramos el pipe
	pclose(pipe);
	
	return 0;
}	

int main(int argn, char** args){
	//Levanto de un archivo los datos correspondientes a la calibración de la cámara
	//Focal length
	Mat fc = Mat::zeros(2,1,6);
	fc.at<double>(Point(0,0)) = 525.060143149240389;
	fc.at<double>(Point(0,1)) = 524.245488213640215;
	
	//Principal point
	Mat cc = Mat::zeros(2,1,6);
	cc.at<double>(Point(0,0)) = 308.649343121753361;
	cc.at<double>(Point(0,1)) = 236.536005491807288;
	
	//Distortion coefficients
	Mat kc = Mat::zeros(5,1,6);
	kc.at<double>(Point(0,0)) = 0.129994935606310;
	kc.at<double>(Point(0,1)) = -0.208923065713290;
	kc.at<double>(Point(0,2)) =  0.000587116057222;
	kc.at<double>(Point(0,3)) = -0.001555033374220 ;
	
	//Matriz de calibración
	Mat K = Mat::zeros(3,3,6);
	K.at<double>(Point(0,0)) = 525.060143149240389;
	K.at<double>(Point(1,1)) = 524.245488213640215;
	K.at<double>(Point(2,0)) = 308.649343121753361;
	K.at<double>(Point(2,1)) = 236.536005491807288;
	K.at<double>(Point(2,2)) = 1;
	
	//Genero la matriz de la cámara P
	Mat Pcam;	
	Mat t = Mat::zeros(3,1,6);
	hconcat(K, t, Pcam);
	
	//Archivo que va a almacenar el recorrido y almaceno la posición inicial
	ofstream out;
	out.open("out.txt");
	Mat pos = Mat::zeros(3,1,6);
	out << pos.at<double>(0) <<" "<< pos.at<double>(1) <<" "<< pos.at<double>(2) << "\n";

	//Abro los videos para la lectura
	char* nombre_video = NULL;
	nombre_video = args[1];
	VideoCapture v1(nombre_video);
	if(!v1.isOpened()){
		cout << "ERROR al abrir el video de lectura" << endl;
		return 0;
	}
	
	//Obtengo el primer frame
	Mat image1, image2, image;
	v1 >> image1;

	//Variables para graficar
	srand(10);
	int r,g,b;
	
	cvNamedWindow("Comparación de imagenes", CV_WINDOW_NORMAL);
	
	//Variables a generar en cada iteración
	Mat W, U, Vt, D;
	Mat R1, R2, Rfinal, Racum, Rnorm;		
	Racum = Mat::eye(3, 3, 6);
	Mat T1, T2, Tfinal;
	
	//Matriz establecida utilizada en el cálculo de la matriz de rotación
	W = Mat::zeros(3,3,6);
	W.at<double>(Point(1,0)) = -1;
	W.at<double>(Point(0,1)) = 1;
	W.at<double>(Point(2,2)) = 1;
	//cout <<"\n----\nW:\n" << W << "\n";
	
	//Transformación de la imagen para compensar la distorción de la misma
	Mat image1_new;
	undistort(image1, image1_new, K, kc);

	//Cantidad de frames a ignorar en la comparación
	int saltoFrames = atoi(args[2]);

	while(v1.read(image2)){
		
		//Ignoro los siguientes "saltoFrames"
		int j=0; 
		while(v1.read(image2)){
			j++;
			if(j > saltoFrames ) break; 
		}
	
		if(j<=saltoFrames) break;	

		Mat image2_new;
		undistort(image2, image2_new, K, kc);
		//Consigo los puntos de correspondencia
		vector<Vec2f> points1, points2;
		get_correspondences(image1_new, image2_new, points1, points2);
		if(points1.size()==0 || points2.size()==0){
			perror("No se encontraron puntos de correspondencia");
			return 0;
		}

		Mat F = findFundamentalMat(points1, points2, CV_FM_RANSAC);

		Mat E = K.t() * F * K ;

		SVD::compute(E, D, U, Vt, SVD::MODIFY_A);
		
		double detVt = determinant(Vt);
		double detU = determinant(U);
			
		//Verifico cual es la descomposición de SVD que corresponde	
		if(detVt < 0 || detU < 0){
			E = (-1)*E;
			SVD::compute((-1)*E, D, U, Vt, SVD::MODIFY_A);
		}
		
		R1 = U * W.t() * Vt;
		R2 = U * W * Vt;

		SVD::solveZ(E, T1);
		T2 = -T1;
		
		//Genero las 4 matrices de la cámara P'
		Mat RTtemp[4], Ptemp[4];
		hconcat(R1, T1, RTtemp[0]);
		hconcat(R1, T2, RTtemp[1]);
		hconcat(R2, T1, RTtemp[2]);
		hconcat(R2, T2, RTtemp[3]);
		
		Ptemp[0] = K * RTtemp[0];
		Ptemp[1] = K * RTtemp[1];
		Ptemp[2] = K * RTtemp[2];
		Ptemp[3] = K * RTtemp[3];
		
		int posibleP[4];
		posibleP[0]=0;
		posibleP[1]=0;
		posibleP[2]=0;
		posibleP[3]=0;
		
		Vec2f p1, p2;
		for(uint i=0; i<points1.size(); i++){
			p1 = points1[i];
			p2 = points2[i];
		
			//Triangulate Points
			Mat Q1, Q2, Q3, Q4;
			triangulatePoints(Pcam, Ptemp[0], p1, p2, Q1); 
			triangulatePoints(Pcam, Ptemp[1], p1, p2, Q2); 
			triangulatePoints(Pcam, Ptemp[2], p1, p2, Q3); 
			triangulatePoints(Pcam, Ptemp[3], p1, p2, Q4);
				
			Q1.convertTo(Q1,6);
			Q2.convertTo(Q2,6);
			Q3.convertTo(Q3,6);
			Q4.convertTo(Q4,6);
		
			Mat PQ1 = Ptemp[0] * Q1;
			Mat PQ2 = Ptemp[1] * Q2;
			Mat PQ3 = Ptemp[2] * Q3;
			Mat PQ4 = Ptemp[3] * Q4;		
		
			double c1 = Q1.at<double>(2)*Q1.at<double>(3);
			double c2 = Q2.at<double>(2)*Q2.at<double>(3);
			double c3 = Q3.at<double>(2)*Q3.at<double>(3);
			double c4 = Q4.at<double>(2)*Q4.at<double>(3);
			
			double c1_2 = PQ1.at<double>(2)*Q1.at<double>(3);
			double c2_2 = PQ2.at<double>(2)*Q2.at<double>(3);
			double c3_2 = PQ3.at<double>(2)*Q3.at<double>(3);
			double c4_2 = PQ4.at<double>(2)*Q4.at<double>(3);
			
			if(c1 > 0 && c1_2 > 0){
				posibleP[0]++;
			}else if(c2 > 0 && c2_2 > 0){
				posibleP[1]++;
			}else if(c3 > 0 && c3_2 > 0){
				posibleP[2]++;
			}else if(c4 > 0 && c4_2 > 0){
				posibleP[3]++;
			}
			
		}
		
		//Busco la P' que obtivo mayor cantidad de "votos"
		int votos=0;
		int eleccion=-1;
		for(int i=0; i<4; i++){
			if(posibleP[i]>votos){
				votos=posibleP[i];
				eleccion=i;
			}
		}
		
		if(eleccion==-1){
			perror("ERROR ELIGIENDO LA P' DOS");
			return 0;
		}
		
		//Genero la matriz de traslación y rotación
		Tfinal = RTtemp[eleccion].col(3);
		Rfinal = Mat(RTtemp[eleccion], Range(0,3), Range(0,3));
		
		//Normalizo las matrices
		Tfinal.at<double>(0) = Tfinal.at<double>(0)/Tfinal.at<double>(2);
		Tfinal.at<double>(1) = Tfinal.at<double>(1)/Tfinal.at<double>(2);
		Tfinal.at<double>(2) = 1;
		Racum = Rfinal * Racum;
		normalize(Racum,Rnorm);
		pos = pos + Rnorm * Tfinal;
				
		//Almaceno la nueva posición
		out << pos.at<double>(0) <<" "<< pos.at<double>(1) <<" "<< pos.at<double>(2) << "\n";
		
		//Muestro en ventana las imágenes y las correspondencias obtenidas
		hconcat(image1_new, image2_new, image);
		for(unsigned int i=0; i< points2.size() && i< points1.size(); i++){
			r = rand()%256;
			g = rand()%256;
			b = rand()%256;
			
			circle(image, Point(points1[i][0],points1[i][1]), 5, CV_RGB(r, g, b), 10);
			circle(image, Point(points2[i][0]+image2.cols,points2[i][1]), 5, CV_RGB(r, g, b), 10);
		}
		imshow("Comparación de imagenes",image);
		waitKey(1);
		image1_new = image2_new.clone();
	}

	out.close();
	
	graficarMov();
	return 0;
}

