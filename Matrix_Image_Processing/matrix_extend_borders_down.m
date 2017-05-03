% Crea la matrice di estensione al bordo inferiore di una immagine
%
% E = MATRIX_EXTEND_BORDERS_DOWN( D, EXT, M, N )
%
% D = dimensione della estensione al bordo inferiore
% EXT = stringa per il tipo di estensione al bordo inferiore
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = estensione periodica
% M = numero di righe della matrice da estendere
% N = numero di colonne della matrice da estendere
%
% E = matrice di estensione
%
function E = matrix_extend_borders_down(n, ext, M, N)
if ext=='e'
    IM = sparse([zeros(n,M-n) flipud(eye(n))]);
elseif ext=='o'
    IM = sparse([zeros(n,M-n-1) flipud(eye(n)) zeros(n,1)]);
elseif ext=='z'
    IM = sparse(zeros(n,M));
elseif ext=='p'
    IM = sparse([eye(n) zeros(n,M-n)]);
else
    IM = sparse([]);
end
E = [speye(M); IM];
E = kron(speye(N), E);
end
