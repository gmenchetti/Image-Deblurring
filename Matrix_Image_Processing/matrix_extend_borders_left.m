% Crea la matrice di estensione al bordo sinistro di una immagine
%
% E = MATRIX_EXTEND_BORDERS__LEFT( D, EXT, M, N )
%
% D = dimensione della estensione al bordo sinistro
% EXT = stringa per il tipo di estensione al bordo sinistro
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = estensione periodica
% M = numero di righe della matrice da estendere
% N = numero di colonne della matrice da estendere
%
% E = matrice di estensione
%
function E = matrix_extend_borders_left(n, ext, M, N)
if ext=='e'
    IN = sparse([flipud(eye(n)) zeros(n,N-n)]);
elseif ext=='o'
    IN = sparse([zeros(n,1) flipud(eye(n)) zeros(n,N-n-1)]);
elseif ext=='z'
    IN = sparse(zeros(n,N));
elseif ext=='p'
    IN = sparse([zeros(n,N-n) eye(n)]);
else
    IN = sparse([]);
end
E = [IN; speye(N)];
E = kron(E, speye(M));
end
