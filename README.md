# Image_Deblurring
Image deblurring method for grayscale image
MATLAB code for my thesis for image linear motion deblurring blind and non-blind. 
As speciefied in the PDF file, the method for the estimation of PSF it's not so accurated mostly because when the values length and theta are estimated, i reconstruct the PSF using the MATLAB method fspecial.

To run the code:
1. Open test_blind/test_non_blind file
2. Select image
3. Select PSF values (length and angle)
4. For GPSR and l1_ls resolution methods change parameters lambda_image (0.1-0.001) and rel_tol_image (100-0.0001)
5. Run the code
