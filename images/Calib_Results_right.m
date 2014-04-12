% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 869.209256494841611 ; 868.978584542873364 ];

%-- Principal point:
cc = [ 315.733613799657007 ; 233.872398233381006 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.078124144853382 ; -0.047917569440079 ; -0.003254459367118 ; -0.003270137602041 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.310885206743154 ; 4.883437615621618 ];

%-- Principal point uncertainty:
cc_error = [ 3.943463875629384 ; 5.012737062046715 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.027660636702183 ; 0.271686484910913 ; 0.001197881636879 ; 0.001255007225494 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 8;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.041625e+00 ; 2.244183e+00 ; -8.813421e-02 ];
Tc_1  = [ -1.545297e+02 ; -1.720088e+02 ; 7.846617e+02 ];
omc_error_1 = [ 3.382286e-03 ; 4.026443e-03 ; 7.654056e-03 ];
Tc_error_1  = [ 3.587874e+00 ; 4.495496e+00 ; 4.716857e+00 ];

%-- Image #2:
omc_2 = [ 2.117372e+00 ; 2.165165e+00 ; -1.883862e-01 ];
Tc_2  = [ -1.422663e+02 ; -1.680732e+02 ; 7.634815e+02 ];
omc_error_2 = [ 3.284522e-03 ; 3.824308e-03 ; 7.246758e-03 ];
Tc_error_2  = [ 3.484706e+00 ; 4.343963e+00 ; 4.659590e+00 ];

%-- Image #3:
omc_3 = [ 1.809778e+00 ; 1.801838e+00 ; -7.938285e-01 ];
Tc_3  = [ -1.703764e+02 ; -1.296529e+02 ; 8.185517e+02 ];
omc_error_3 = [ 3.421952e-03 ; 4.728344e-03 ; 6.504519e-03 ];
Tc_error_3  = [ 3.725587e+00 ; 4.693176e+00 ; 4.675686e+00 ];

%-- Image #4:
omc_4 = [ 1.808477e+00 ; 1.803902e+00 ; -7.928932e-01 ];
Tc_4  = [ -1.693838e+02 ; -1.310937e+02 ; 8.181238e+02 ];
omc_error_4 = [ 3.423429e-03 ; 4.730858e-03 ; 6.505895e-03 ];
Tc_error_4  = [ 3.724162e+00 ; 4.689948e+00 ; 4.674463e+00 ];

%-- Image #5:
omc_5 = [ -2.127230e+00 ; -2.131958e+00 ; 6.551771e-01 ];
Tc_5  = [ -1.170102e+02 ; -1.505330e+02 ; 8.451338e+02 ];
omc_error_5 = [ 4.193992e-03 ; 2.805343e-03 ; 8.131467e-03 ];
Tc_error_5  = [ 3.844634e+00 ; 4.815636e+00 ; 4.951571e+00 ];

%-- Image #6:
omc_6 = [ -2.111817e+00 ; -2.130393e+00 ; 6.636664e-01 ];
Tc_6  = [ -1.123188e+02 ; -1.491543e+02 ; 8.434408e+02 ];
omc_error_6 = [ 4.170643e-03 ; 2.822471e-03 ; 8.117609e-03 ];
Tc_error_6  = [ 3.835702e+00 ; 4.806104e+00 ; 4.928415e+00 ];

%-- Image #7:
omc_7 = [ 1.936772e+00 ; 2.079007e+00 ; 2.291342e-02 ];
Tc_7  = [ -1.524939e+02 ; -1.636234e+02 ; 7.383069e+02 ];
omc_error_7 = [ 3.927460e-03 ; 3.763744e-03 ; 6.550648e-03 ];
Tc_error_7  = [ 3.389411e+00 ; 4.230253e+00 ; 4.516386e+00 ];

%-- Image #8:
omc_8 = [ 1.936089e+00 ; 2.077185e+00 ; 2.847250e-02 ];
Tc_8  = [ -1.524019e+02 ; -1.669961e+02 ; 7.364105e+02 ];
omc_error_8 = [ 3.941044e-03 ; 3.773269e-03 ; 6.550911e-03 ];
Tc_error_8  = [ 3.382515e+00 ; 4.219605e+00 ; 4.508754e+00 ];

