% Crea la matrice di trasposizione di una immagine
%
% T = MATRIX_TRANSPOSE( M, N )
%
% M = numero di righe della matrice da trasporre
% N = numero di colonne della matrice da trasporre
%
% T = matrice di trasposizione
%
function T = matrix_transpose( M, N )
IM = speye(M);
T = sparse([]);
for k=1:M
    T = [T; kron(speye(N),IM(k,:))];
end
end

