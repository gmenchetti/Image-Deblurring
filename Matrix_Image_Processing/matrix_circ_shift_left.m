% Crea la matrice di traslazione circolare verso sinistra di una immagine
%
% E = MATRIX_CIRC_SHIFT_LEFT( D, M, N )
%
% D = dimensione della traslazione verso sinistra
% M = numero di righe della matrice da traslare
% N = numero di colonne della matrice da traslare
%
% E = matrice di shift
%
function E = matrix_circ_shift_left(d, M, N)
E = circshift(speye(N), -d);
E = kron(E, speye(M));
end
