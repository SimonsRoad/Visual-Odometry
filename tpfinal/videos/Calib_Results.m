% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/
% Pixel error:          err = [ 0.25937   0.25207 ]

%-- Focal length:
fc = [ 525.060143149240389 ; 524.245488213640215 ];

%-- Principal point:
cc = [ 308.649343121753361 ; 236.536005491807288 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.129994935606310 ; -0.208923065713290 ; 0.000587116057222 ; -0.001555033374220 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 1.222623784913799 ; 1.222723632510600 ];

%-- Principal point uncertainty:
cc_error = [ 1.366886637966628 ; 1.143888167807741 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.005550320628393 ; 0.012390093860385 ; 0.000733343698068 ; 0.000714908383970 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.402159e+00 ; -2.636712e+00 ; -1.489036e-01 ];
Tc_1  = [ -2.863390e+01 ; -2.030121e+02 ; 4.762752e+02 ];
omc_error_1 = [ 1.469935e-03 ; 2.625315e-03 ; 4.443706e-03 ];
Tc_error_1  = [ 1.266347e+00 ; 1.083682e+00 ; 1.350149e+00 ];

%-- Image #2:
omc_2 = [ NaN ; NaN ; NaN ];
Tc_2  = [ NaN ; NaN ; NaN ];
omc_error_2 = [ NaN ; NaN ; NaN ];
Tc_error_2  = [ NaN ; NaN ; NaN ];

%-- Image #3:
omc_3 = [ NaN ; NaN ; NaN ];
Tc_3  = [ NaN ; NaN ; NaN ];
omc_error_3 = [ NaN ; NaN ; NaN ];
Tc_error_3  = [ NaN ; NaN ; NaN ];

%-- Image #4:
omc_4 = [ 2.208348e+00 ; 2.192956e+00 ; -1.281178e-01 ];
Tc_4  = [ -1.303422e+02 ; -1.539315e+02 ; 4.243584e+02 ];
omc_error_4 = [ 1.712720e-03 ; 1.687198e-03 ; 3.590071e-03 ];
Tc_error_4  = [ 1.093184e+00 ; 9.218440e-01 ; 1.130209e+00 ];

%-- Image #5:
omc_5 = [ 2.214597e+00 ; 2.170395e+00 ; -7.189770e-02 ];
Tc_5  = [ -2.094867e+02 ; -1.544616e+02 ; 4.191557e+02 ];
omc_error_5 = [ 1.676785e-03 ; 1.969255e-03 ; 3.931342e-03 ];
Tc_error_5  = [ 1.086739e+00 ; 9.371515e-01 ; 1.236489e+00 ];

%-- Image #6:
omc_6 = [ -1.352049e+00 ; -2.696115e+00 ; -1.147003e-01 ];
Tc_6  = [ -1.079678e+02 ; -1.941617e+02 ; 4.766614e+02 ];
omc_error_6 = [ 1.542569e-03 ; 2.613422e-03 ; 4.276086e-03 ];
Tc_error_6  = [ 1.252869e+00 ; 1.076535e+00 ; 1.330751e+00 ];

%-- Image #7:
omc_7 = [ NaN ; NaN ; NaN ];
Tc_7  = [ NaN ; NaN ; NaN ];
omc_error_7 = [ NaN ; NaN ; NaN ];
Tc_error_7  = [ NaN ; NaN ; NaN ];

%-- Image #8:
omc_8 = [ 2.174734e+00 ; 2.245304e+00 ; -1.076330e-01 ];
Tc_8  = [ -8.881040e+01 ; -1.688203e+02 ; 4.126311e+02 ];
omc_error_8 = [ 1.807428e-03 ; 1.707450e-03 ; 3.627212e-03 ];
Tc_error_8  = [ 1.070775e+00 ; 8.928388e-01 ; 1.094895e+00 ];

%-- Image #9:
omc_9 = [ -2.186722e+00 ; -2.157623e+00 ; -2.980923e-02 ];
Tc_9  = [ -1.046954e+02 ; -1.442756e+02 ; 3.853276e+02 ];
omc_error_9 = [ 1.554598e-03 ; 1.779286e-03 ; 3.523492e-03 ];
Tc_error_9  = [ 1.012704e+00 ; 8.526817e-01 ; 1.033085e+00 ];

%-- Image #10:
omc_10 = [ -2.197628e+00 ; -2.204110e+00 ; -1.235234e-02 ];
Tc_10  = [ -1.339656e+02 ; -1.455540e+02 ; 3.640538e+02 ];
omc_error_10 = [ 1.493307e-03 ; 1.593109e-03 ; 3.311850e-03 ];
Tc_error_10  = [ 9.565509e-01 ; 8.102979e-01 ; 9.942985e-01 ];

%-- Image #11:
omc_11 = [ 2.064527e+00 ; 8.594185e-01 ; 1.079542e+00 ];
Tc_11  = [ -1.825680e+02 ; -3.995592e+01 ; 3.453956e+02 ];
omc_error_11 = [ 2.748396e-03 ; 1.683117e-03 ; 3.553308e-03 ];
Tc_error_11  = [ 8.846107e-01 ; 7.911671e-01 ; 1.362385e+00 ];

%-- Image #12:
omc_12 = [ NaN ; NaN ; NaN ];
Tc_12  = [ NaN ; NaN ; NaN ];
omc_error_12 = [ NaN ; NaN ; NaN ];
Tc_error_12  = [ NaN ; NaN ; NaN ];

%-- Image #13:
omc_13 = [ NaN ; NaN ; NaN ];
Tc_13  = [ NaN ; NaN ; NaN ];
omc_error_13 = [ NaN ; NaN ; NaN ];
Tc_error_13  = [ NaN ; NaN ; NaN ];

%-- Image #14:
omc_14 = [ -2.183769e+00 ; -1.397408e+00 ; 1.244286e+00 ];
Tc_14  = [ -3.496367e+01 ; -3.912099e+01 ; 6.748176e+02 ];
omc_error_14 = [ 2.840486e-03 ; 1.560956e-03 ; 3.661910e-03 ];
Tc_error_14  = [ 1.767378e+00 ; 1.431779e+00 ; 1.277217e+00 ];

%-- Image #15:
omc_15 = [ NaN ; NaN ; NaN ];
Tc_15  = [ NaN ; NaN ; NaN ];
omc_error_15 = [ NaN ; NaN ; NaN ];
Tc_error_15  = [ NaN ; NaN ; NaN ];

%-- Image #16:
omc_16 = [ 1.728133e+00 ; 1.822847e+00 ; 1.151554e+00 ];
Tc_16  = [ -3.458753e+02 ; -7.550089e+01 ; 6.606766e+02 ];
omc_error_16 = [ 3.357816e-03 ; 2.848718e-03 ; 4.456322e-03 ];
Tc_error_16  = [ 1.811161e+00 ; 1.538061e+00 ; 2.402110e+00 ];

%-- Image #17:
omc_17 = [ NaN ; NaN ; NaN ];
Tc_17  = [ NaN ; NaN ; NaN ];
omc_error_17 = [ NaN ; NaN ; NaN ];
Tc_error_17  = [ NaN ; NaN ; NaN ];

%-- Image #18:
omc_18 = [ -1.343669e+00 ; -2.727989e+00 ; -8.518901e-02 ];
Tc_18  = [ 4.506669e+01 ; -2.077996e+02 ; 4.929671e+02 ];
omc_error_18 = [ 1.431027e-03 ; 2.927689e-03 ; 4.741907e-03 ];
Tc_error_18  = [ 1.313326e+00 ; 1.112245e+00 ; 1.402691e+00 ];

%-- Image #19:
omc_19 = [ -1.899594e+00 ; -1.981880e+00 ; 7.883245e-01 ];
Tc_19  = [ -2.616938e+01 ; -1.503043e+02 ; 5.880313e+02 ];
omc_error_19 = [ 2.307742e-03 ; 1.957188e-03 ; 3.827654e-03 ];
Tc_error_19  = [ 1.523312e+00 ; 1.244157e+00 ; 1.332174e+00 ];

%-- Image #20:
omc_20 = [ -1.680524e+00 ; -1.582509e+00 ; 3.648854e-01 ];
Tc_20  = [ 1.293371e+02 ; -1.064463e+02 ; 8.260578e+02 ];
omc_error_20 = [ 2.357330e-03 ; 2.725473e-03 ; 4.059747e-03 ];
Tc_error_20  = [ 2.230204e+00 ; 1.793884e+00 ; 2.208568e+00 ];

