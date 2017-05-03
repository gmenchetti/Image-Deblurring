% Crea la matrice di convoluzione per colonne di una immagine
%
% A = MATRIX_CONV_COL( H, M, N )
%
% H = coefficienti del filtro
% M = numero di righe della matrice da convolvere
% N = numero di colonne della matrice da convolvere
%
% A = matrice di convoluzione
%
function A = matrix_conv_col( h, M, N )
% impongo al vettore h di essere colonna
h = h(:);

% calcolo la matrice di convoluzione per una singola colonna:
B = sparse(toeplitz([h; zeros(M-1,1)],[h(1) zeros(1,M-1)]));

% creo la matrice di convoluzione a blocchi per tutte le colonne
% A = kronecker(I,B)
A = kron(speye(N),B);

end

