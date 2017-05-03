% Crea la matrice di convoluzione per righe di una immagine
%
% A = MATRIX_CONV_ROW( H, M, N )
%
% H = coefficienti del filtro
% M = numero di righe della matrice da convolvere
% N = numero di colonne della matrice da convolvere
%
% A = matrice di convoluzione
%
function A = matrix_conv_row( h, M, N )
% impongo al vettore h di essere colonna
h = h(:);

% calcolo la matrice di convoluzione per una singola riga:
B = sparse(toeplitz([h; zeros(N-1,1)],[h(1) zeros(1,N-1)]));

% creo la matrice di convoluzione a blocchi per tutte le righe
% A = kronecker(B,I)
A = kron(B, speye(M));

end

