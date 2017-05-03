% Funzione che crea il kernel stimando i parametri della PSF
%
% [kernel, length, theta] = get_kernel( X )
%
% X = IMMAGINE BLUR
%
% kernel = PSF STIMATA
% LENGTH = LUNGHEZZA STIMATA
% THETA = ANGOLO STIMATO
function [kernel, LENGTH, THETA] = get_kernel( X )
    THETA = angle_estimation(X);
    LENGTH = ceil(length_estimation(X, THETA));
    kernel = fspecial('motion', LENGTH, THETA-1); % Si esegue THETA-1 perch? gli indici vanno da 1-180
end

