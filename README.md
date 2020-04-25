# Image_Deblurring
This project was presented as my Bachelor's Thesis at Università degli Studi di Firenze.
## Description
The aim of the project is to remove linear uniform motion blur from grayscale images, using the Wavelet Transform.

We also propose a method to estimate the parameters of the Point Spread Function (PSF).

The file https://github.com/gmenchetti/Image-Deblurring/blob/master/docs/Thesis.pdf gives more information about the project (unfortunately, it is only available in Italian).

## Run
To run the code:
1. Open test_blind/test_non_blind file
2. Select image
3. Select PSF values (length and angle)
4. For GPSR and l1_ls resolution methods change parameters lambda_image (0.1-0.001) and rel_tol_image (100-0.0001)
5. Run the code
