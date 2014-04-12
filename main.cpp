#include <opencv2/core/core.hpp>
#include <iostream>
#include <highgui.h>
#include <opencv/cv.h>
#include <opencv2/contrib/contrib.hpp>
#include <opencv2/highgui/highgui.hpp>
#include "opencv2/opencv.hpp"

using namespace std;
using namespace cv;

Mat desplazarImagen(Mat image, int disp){
	
	Mat res;
	Mat ceros;
	Mat desp;
	int size;
	if(disp != 50){
		if(disp > 50){
			size = image.cols * (disp-50) / 100;
			ceros = Mat::zeros(image.rows,size, image.type());
			desp = Mat(image,Range(0,image.rows),Range(0,image.cols-size));
			
			hconcat(ceros,desp,res);
			
		}else{
			size = image.cols * (50-disp) / 100;
			ceros = Mat::zeros(image.rows,size, image.type());
			desp = Mat(image,Range(0,image.rows),Range(size,image.cols));
			
			hconcat(desp,ceros,res);
		}
	}else{
		res = image;
	}
	
	return res;
	}

int main(int argn, char** args){
	
	Mat P1;
	Mat P2;
	Mat d1;
	Mat d2;
	Mat R;
	Mat T;
	
	cout << "\nOPENCV LEVANTANDO DATOS DE XML\n";
	
	String path = "parameters-640x480.xml";
	FileStorage file(path, FileStorage::READ);
	
	if(!file.isOpened()){
		cout << "ERROR ABRIENDO ARCHIVO: " << path;
		return -1;
		}
	
	cout << "ARCHIVO '" << path << "' ABIERTO CORRECTAMENTE\n";
	

	
	read(file["P1"], P1,    Mat() );
	read(file["P2"], P2,    Mat() );
	read(file["dist1"], d1,    Mat() );
	read(file["dist2"], d2,    Mat() );
	read(file["R"], R,    Mat() );
	read(file["T"], T,    Mat() );
	
	cout << "\n---    ---\n\n";
	cout << "P1: \n" << P1 << endl;
	cout << "\n---    ---\n\n";
	cout << "P2: \n" << P2 << endl;
	cout << "\n---    ---\n\n";
	cout << "Distortion 1: \n" << d1 << endl;
	cout << "\n---    ---\n\n";
	cout << "Distortion 2: \n" << d2 << endl;
	cout << "\n---    ---\n\n";
	cout << "R: \n" << R << endl;
	cout << "\n---    ---\n\n";
	cout << "T: \n" << T << endl;
	cout << "\n---    ---\n\n";
	
	file.release();
	
	cout << "DATOS LEIDOS CORRECTAMENTE\n";
	
	//Abro los videos para la lectura
	VideoCapture v1("videos/cam1.avi");
	if(!v1.isOpened()){
		cout << "ERROR al abrir el video de lectura" << endl;
		return 0;
	}
	VideoCapture v2("videos/cam2.avi");
	if(!v2.isOpened()){
		cout << "ERROR al abrir el video de lectura" << endl;
		return 0;
	}
	
	Mat imageL;
	Mat imageR;
	
	v1 >> imageL;
	v2 >> imageR;
	
	Mat P1_rectified;
	Mat P2_rectified;
	Mat R1;
	Mat R2;
	Mat Q;
	
	stereoRectify(P1, d1, P2, d2, imageL.size() ,R,T,R1,R2,P1_rectified,P2_rectified,Q);
	
	Mat map1;
	Mat map2;
	Mat P1_new;
	Mat imageL_new;
	
	initUndistortRectifyMap(P1, d1, R1, P1_new, imageL.size(), CV_32FC1, map1, map2);
	
	Mat map3;
	Mat map4;
	Mat P2_new;
	Mat imageR_new;
	
	initUndistortRectifyMap(P2, d2, R2, P2_new, imageR.size(), CV_32FC1, map3, map4);
	
	remap(imageL, imageL_new, map1, map2, INTER_LINEAR, BORDER_CONSTANT);
	remap(imageR, imageR_new, map3, map4, INTER_LINEAR, BORDER_CONSTANT);
	
	int max = 100;
	int disp=max/2;
	
	cvStartWindowThread();
	cvNamedWindow("Calibración",CV_WINDOW_NORMAL);
	createTrackbar("Disparidad","Calibración",&disp,max);
	
	Mat tras;
	Mat imSum;
	Mat movR;
	Mat movL;
	
	char key=0;
	
	while(key<=0){
		
		movR = desplazarImagen(imageR_new, disp);
		addWeighted(imageL_new, 0.5, movR, 0.5, 0, imSum);
		imshow("Calibración",imSum);
		
		key=waitKey(1);
	}
	
	StereoBM stereo;
	Mat disparityMap;
	Mat disparityMap2;
	double minC, maxC;
	float scale;
	
	//Escritura en el video
	int width = v1.get(CV_CAP_PROP_FRAME_WIDTH);
	int height = v1.get(CV_CAP_PROP_FRAME_HEIGHT);
	CvSize tmp = cvSize(width, height);
//	VideoWriter v("videos/out.avi", v1.get(CV_CAP_PROP_FOURCC), v1.get(CV_CAP_PROP_FPS), tmp);
	VideoWriter v("videos/out.avi", CV_FOURCC('M','J','P','G'), v1.get(CV_CAP_PROP_FPS), tmp);
	
	if(!v.isOpened()){
		cout << "ERROR al abrir el video de escritura" << endl;
		return 0;
	}
	
	cvNamedWindow("Video Disparidad Gris", CV_WINDOW_NORMAL);
	cvNamedWindow("Video Disparidad BN", CV_WINDOW_NORMAL);
	cvNamedWindow("Video Disparidad Color", CV_WINDOW_NORMAL);

	

	while(v1.read(imageL) && v2.read(imageR) ){

		//PROCESAMIENTO
		remap(imageL, imageL_new, map1, map2, INTER_LINEAR, BORDER_CONSTANT);
		remap(imageR, imageR_new, map3, map4, INTER_LINEAR, BORDER_CONSTANT);


		movR = desplazarImagen(imageR_new, disp);
		
		//MUESTRO EL VIDEO SUPERPUESTO
		addWeighted(imageL_new, 0.5, movR, 0.5, 0, imSum);
		imshow("Calibración",imSum);


		cvtColor(imageL_new, imageL_new, CV_BGR2GRAY);
		cvtColor(movR, movR, CV_BGR2GRAY);

		stereo(imageL_new,movR,disparityMap);
	
		minMaxIdx(disparityMap, &minC, &maxC);
		scale = 255 / (maxC-minC);

		imshow("Video Disparidad Gris",disparityMap);

		disparityMap.convertTo(disparityMap2, CV_8UC3, scale, -minC*scale);
	
		imshow("Video Disparidad BN",disparityMap2);

		applyColorMap(disparityMap2, disparityMap, COLORMAP_JET);
	
		imshow("Video Disparidad Color",disparityMap);
	

		v << disparityMap;
		
		waitKey(1);
		
	}
	
	return 0;

}
