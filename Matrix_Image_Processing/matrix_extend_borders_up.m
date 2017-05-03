% Crea la matrice di estensione al bordo superiore bordi di una immagine
%
% E = MATRIX_EXTEND_BORDERS__UP( D, EXT, M, N )
%
% D = dimensione della estensione al bordo superiore
% EXT = stringa per il tipo di estensione al bordo
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = estensione periodica
% M = numero di righe della matrice da estendere
% N = numero di colonne della matrice da estendere
%
% E = matrice di estensione
%
function E = matrix_extend_borders_up(n, ext, M, N)
if ext=='e'
    IM = sparse([flipud(eye(n)) zeros(n,M-n)]);
elseif ext=='o'
    IM = sparse([zeros(n,1) flipud(eye(n)) zeros(n,M-n-1)]);
elseif ext=='z'
    IM = sparse(zeros(n,M));
elseif ext=='p'
    IM = sparse([zeros(n,M-n) eye(n)]);
else
    IM = sparse([]);
end
E = [IM; speye(M)];
E = kron(speye(N), E);
end
