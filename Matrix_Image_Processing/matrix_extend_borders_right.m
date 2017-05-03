% Crea la matrice di estensione al bordo destro di una immagine
%
% E = MATRIX_EXTEND_BORDERS_RIGHT( D, EXT, M, N )
%
% D = dimensione delle estensione al bordo destro
% EXT = stringa per il tipo di estensione al bordo destro
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = estensione periodica
% M = numero di righe della matrice da estendere
% N = numero di colonne della matrice da estendere
%
% E = matrice di estensione
%
function E = matrix_extend_borders_right(n, ext, M, N)
if ext=='e'
    IN = sparse([zeros(n,N-n) flipud(eye(n))]);
elseif ext=='o'
    IN = sparse([zeros(n,N-n-1) flipud(eye(n)) zeros(n,1)]);
elseif ext=='z'
    IN = sparse(zeros(n,N));
elseif ext=='p'
    IN = sparse([eye(n) zeros(n,N-n)]);
else
    IN = sparse([]);
end
E = [speye(N); IN];
E = kron(E, speye(M));
end
