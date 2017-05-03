% Funzione per degradare l'immagine originale
%
% [degraded_image, PSF, H_filter] = degrade_image(image_deblurred, LEN, THETA)
% image_deblurred = IMMAGINE ORIGINALE
% LEN = LUNGHEZZA DEL BLUR
% THETA = ANGOLO DEL BLUR
% NOISE_VAR = VARIANZA DEL RUMORE
%
% degraded_image = IMMAGINE DEGRADATA
% PSF = PSF UTILIZZATA
% H_filter = FILTRO CONVOLUTIVO PER LA DEGRADAZIONE

function [degraded_image, image_deblurred, PSF, H_filter] = degrade_image(image_deblurred, LEN, THETA, NOISE_VAR)
    %% Converto l'immagine RGB in scala di grigi
    if size(image_deblurred, 3) == 3
        image_deblurred = double(rgb2gray(image_deblurred));
    else
        image_deblurred = double(image_deblurred);
    end
    
    [M, N] = size(image_deblurred);

    %% Creo la PSF
    PSF = fspecial('motion', LEN, THETA);
    PSF = pad_PSF(PSF);

    %% Creo la matrice di convoluzione ed eseguo applico il Blur
    H_filter = matrix_filter2D(PSF, 'o', M, N, 0, 0);
    degraded_image = H_filter*image_deblurred(:);

    %% Aggiungo del rumore Gaussiano
    degraded_image = degraded_image + NOISE_VAR.*randn(size(degraded_image));
    
    degraded_image = reshape(degraded_image, M, N);
end