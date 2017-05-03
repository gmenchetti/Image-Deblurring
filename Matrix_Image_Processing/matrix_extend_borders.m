% Crea la matrice di estensione ai bordi di una immagine
%
% E = matrix_extend( D, EXT, M, N )
%
% D = dimensione delle estensioni ai bordi
%     (vettore di 4 interi, [left down right up])
% EXT = stringa di 4 elementi per il tipo di estensione ad ogni bordo
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = estensione periodica
% M = numero di righe della matrice da estendere
% N = numero di colonne della matrice da estendere
%
% E = matrice di estensione
%
function E = matrix_extend_borders( n, ext, M, N )
E = matrix_extend_borders_left(n(1), ext(1), M, N);
E = matrix_extend_borders_down(n(2), ext(2), M, N+n(1))*E;
E = matrix_extend_borders_right(n(3), ext(3), M+n(2), N+n(1))*E;
E = matrix_extend_borders_up(n(4), ext(4), M+n(2), N+n(1)+n(3))*E;
end

