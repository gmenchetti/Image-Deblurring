folder = fileparts(which(mfilename)); 
addpath(genpath(folder));

M = 256;
N = 256;

% Scelta dell'immagine e del metodo di risoluzione
IM_NUMBER = 2;
SOLVER = 1;

% Parametri della PSF
LENGTH = 25;
ANGLE = 15;
NOISE_VAR = 0.002;

if IM_NUMBER == 0
    X = imread('text.jpg');
    X = X(20:M+20-1, 20:N+20-1);
    name = 'text';
elseif IM_NUMBER == 1
    load lena
    X = imresize(lena, [M, N]);
    name = 'lena';
elseif IM_NUMBER == 2
    X = imread('scimmia-true.png');
    name = 'scimmia';
elseif IM_NUMBER == 3
    X = imread('camera.png');
    name = 'camera';
elseif IM_NUMBER == 4
    X = imread('thai-blur.jpg');
    name = 'thai';
    M = 128;
    N = 128;
end

if IM_NUMBER ~= 4
    %% Degrado l'immagine
    [img_blur, X, PSF, H_filter] = degrade_image(X, LENGTH, ANGLE, NOISE_VAR);
    figure, imshow(X/255), title('Original image');
    figure, imshow(img_blur/255), title('Blurred image');
    %% Stima della PSF
    [PSF_estimated, len, ang] = get_kernel(img_blur/255);
    figure, imshow(pad_PSF(PSF), [], 'InitialMagnification', 'fit'), title('Real PSF');
    figure, imshow(pad_PSF(PSF_estimated), [], 'InitialMagnification', 'fit'), title('Estimated PSF');
    pause
else
    img_blur = double(X);
    figure, imshow(img_blur/255), title('Blurred image');
    %% Stima della PSF
    [PSF_estimated, len, ang] = get_kernel(img_blur/255);
    figure, imshow(pad_PSF(PSF_estimated), [], 'InitialMagnification', 'fit'), title('Estimated PSF');
    pause
end

if SOLVER == 0 || SOLVER == 1
    %% Creo la matrice Wavelet
    levels = 3;
    WR = matrix_dwt2D_synthesis('bior4.4', levels, M, N);
    H_estimated = matrix_filter2D(PSF_estimated, 'o', M, N, 0, 0);
    A = H_estimated*WR;
end
if SOLVER == 0
    %% Risoluzione con GPSR
    lambda_image = 1.e-1;
    rel_tol_image = 1.e-4;
    tic
    [x,x_debias,objective,times,debias_start,mses] = GPSR_BB(img_blur(:), A, lambda_image, ...
        'StopCriterion', 2,...
        'ToleranceA', rel_tol_image);
    time = toc
    image_deblurred = reshape(WR*x, M, N)/255;
    figure, imshow(image_deblurred), title('Image reconstructed');
elseif SOLVER == 1
    %% Risoluzione con L1_LS
    lambda_image = 1.e-1;
    rel_tol_image = 1.e3;
    tic
    [x,status,history] = l1_ls(A, img_blur(:), lambda_image, rel_tol_image);
    time = toc
    image_deblurred = reshape(WR*x, M, N)/255;
    figure, imshow(image_deblurred), title('Image reconstructed');
elseif SOLVER == 2
    %% Risoluzione con Blind
    n_it = 20;
    tic
    image_deblurred = deconvblind(img_blur/255, PSF_estimated, n_it);
    time = toc
    figure, imshow(image_deblurred), title('Image reconstructed');
end