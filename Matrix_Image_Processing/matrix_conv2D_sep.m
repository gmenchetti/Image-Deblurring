% Crea la matrice di convoluzione 2D di una immagine con filtro separabile
% per righe e colonne
%
% A = MATRIX_CONV2D_SEP( HC, HR, M, N )
%
% HC = coefficienti del filtro per colonne
% HR = coefficienti del filtro per righe
% M = numero di righe della matrice da convolvere
% N = numero di colonne della matrice da convolvere
%
% A = matrice di convoluzione 2D
%
function A = matrix_conv2D_sep( hc, hr, M, N )
% il calcolo usa sempre la stessa matrice per non sprecare memoria

% calcolo matrice di convoluzione per colonne
A = matrix_conv_col(hc, M, N);

% convolvo con il filtro per righe 
A = matrix_conv_row(hr, M+length(hc)-1, N ) * A;


end
