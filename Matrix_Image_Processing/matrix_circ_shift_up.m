% Crea la matrice di traslazione circolare verso l'alto di una immagine
%
% E = MATRIX_CIRC_SHIFT_UP( D, M, N )
%
% D = dimensione della traslazione verso l'alto dell'immagine
% M = numero di righe della matrice da traslare
% N = numero di colonne della matrice da traslare
%
% E = matrice di shift
%
function E = matrix_circ_shift_up(d, M, N)
E = circshift(speye(M), -d);
E = kron(speye(N), E);
end
