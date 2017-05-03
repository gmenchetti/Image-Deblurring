folder = fileparts(which(mfilename)); 
addpath(genpath(folder));

M = 256;
N = 256;

% Scelta dell'immagine e del metodo di risoluzione
im_number = 4;
SOLVER = 0;

% Parametri della PSF
LENGTH = 25;
ANGLE = 15;
NOISE_VAR = 0.002;

if im_number == 0
    X = imread('text.jpg');
    X = X(20:M+20-1, 20:N+20-1);
    name = 'text';
elseif im_number == 1
    load lena
    X = imresize(lena, [M, N]);
    name = 'lena';
elseif im_number == 2
    X = imread('scimmia-true.png');
    name = 'scimmia';
elseif im_number == 3
    X = imread('camera.png');
    name = 'camera';
elseif im_number == 4
    X = imread('face-true.png');
    name = 'face';
end


%% Degrado l'immagine
[img_blur, X, PSF, H_filter] = degrade_image(X, LENGTH, ANGLE, NOISE_VAR);

figure, imshow(X/255), title('Original image');
figure, imshow(img_blur/255), title('Blurred image');

if SOLVER == 0 || SOLVER == 1
    %% Creo la matrice Wavelet
    levels = 3;
    WR = matrix_dwt2D_synthesis('bior4.4', levels, M, N);
    A = H_filter*WR;
end
if SOLVER == 0
    %% Risoluzione con GPSR
    solver = 'GPSR';
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
    solver = 'L1_LS';
    lambda_image = 1.e-1;
    rel_tol_image = 1.e2;
    tic
    [x,status,history] = l1_ls(A, img_blur(:), lambda_image, rel_tol_image);
    time = toc
    image_deblurred = reshape(WR*x, M, N)/255;
    figure, imshow(image_deblurred), title('Image reconstructed');
elseif SOLVER == 2
    %% Risoluzione con Lucy-Richardson
    solver = 'LR';
    n_it = 5;
    tic
    image_deblurred = deconvlucy(reshape(img_blur, M, N)/255, PSF, n_it);
    time = toc
    figure, imshow(image_deblurred), title('Image reconstructed');
elseif SOLVER == 3
    %% Risoluzione con Wiener
    solver = 'WF';
    nsr = NOISE_VAR / var(X(:)/255);
    tic
    image_deblurred = deconvwnr(reshape(img_blur, M, N)/255, PSF, nsr);
    time = toc
    figure, imshow(image_deblurred), title('Image reconstructed');
else
    %% Risoluzione con Blind
    solver = 'BD';
    n_it = 20;
    tic
    image_deblurred = deconvblind(reshape(img_blur, M, N)/255, PSF, n_it);
    time = toc
    figure, imshow(image_deblurred), title('Image reconstructed');
end