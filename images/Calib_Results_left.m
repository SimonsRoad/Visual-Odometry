% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 859.076649222904393 ; 858.808321466551888 ];

%-- Principal point:
cc = [ 303.182063153683202 ; 266.180680324437105 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.043952464216796 ; -0.394016376295092 ; -0.003822185006891 ; -0.001569759493935 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.541247212126638 ; 5.111825445944922 ];

%-- Principal point uncertainty:
cc_error = [ 4.139248376112032 ; 5.148079038022490 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.021197489076219 ; 0.159573029620702 ; 0.001198386495828 ; 0.001453989330892 ; 0.000000000000000 ];

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
omc_1 = [ 2.044810e+00 ; 2.233165e+00 ; -7.339313e-02 ];
Tc_1  = [ -9.871357e+01 ; -1.785865e+02 ; 7.768629e+02 ];
omc_error_1 = [ 3.562922e-03 ; 3.905074e-03 ; 7.731854e-03 ];
Tc_error_1  = [ 3.771545e+00 ; 4.598959e+00 ; 4.902402e+00 ];

%-- Image #2:
omc_2 = [ 2.123399e+00 ; 2.162548e+00 ; -1.722513e-01 ];
Tc_2  = [ -8.573917e+01 ; -1.747609e+02 ; 7.565928e+02 ];
omc_error_2 = [ 3.557871e-03 ; 3.770694e-03 ; 7.501518e-03 ];
Tc_error_2  = [ 3.667428e+00 ; 4.446466e+00 ; 4.857407e+00 ];

%-- Image #3:
omc_3 = [ 1.819120e+00 ; 1.804663e+00 ; -7.822989e-01 ];
Tc_3  = [ -1.134469e+02 ; -1.380448e+02 ; 8.118917e+02 ];
omc_error_3 = [ 3.682316e-03 ; 4.680997e-03 ; 6.857483e-03 ];
Tc_error_3  = [ 3.920687e+00 ; 4.792481e+00 ; 4.911598e+00 ];

%-- Image #4:
omc_4 = [ 1.818009e+00 ; 1.802815e+00 ; -7.806449e-01 ];
Tc_4  = [ -1.130617e+02 ; -1.381629e+02 ; 8.116263e+02 ];
omc_error_4 = [ 3.691251e-03 ; 4.677739e-03 ; 6.848744e-03 ];
Tc_error_4  = [ 3.919467e+00 ; 4.790669e+00 ; 4.910649e+00 ];

%-- Image #5:
omc_5 = [ -2.117683e+00 ; -2.116454e+00 ; 6.364899e-01 ];
Tc_5  = [ -5.963069e+01 ; -1.580485e+02 ; 8.353236e+02 ];
omc_error_5 = [ 4.189154e-03 ; 3.118137e-03 ; 8.714514e-03 ];
Tc_error_5  = [ 4.034217e+00 ; 4.914808e+00 ; 5.206303e+00 ];

%-- Image #6:
omc_6 = [ NaN ; NaN ; NaN ];
Tc_6  = [ NaN ; NaN ; NaN ];
omc_error_6 = [ NaN ; NaN ; NaN ];
Tc_error_6  = [ NaN ; NaN ; NaN ];

%-- Image #7:
omc_7 = [ 1.941612e+00 ; 2.070043e+00 ; 3.547706e-02 ];
Tc_7  = [ -9.589683e+01 ; -1.700075e+02 ; 7.304629e+02 ];
omc_error_7 = [ 4.101438e-03 ; 3.659442e-03 ; 6.744870e-03 ];
Tc_error_7  = [ 3.557921e+00 ; 4.318182e+00 ; 4.747652e+00 ];

%-- Image #8:
omc_8 = [ 1.943440e+00 ; 2.074245e+00 ; 2.964594e-02 ];
Tc_8  = [ -9.593234e+01 ; -1.729310e+02 ; 7.331957e+02 ];
omc_error_8 = [ 4.080721e-03 ; 3.682150e-03 ; 6.762915e-03 ];
Tc_error_8  = [ 3.571865e+00 ; 4.333152e+00 ; 4.760857e+00 ];

