% Crea la matrice di sottocampionamento per colonne di una immagine
%
% E = MATRIX_DOWNSAMP_COL( D, M, N, DELAY )
%
% D = fattore di sottocampionamento
% M = numero di righe della matrice da sottocampionare
% N = numero di colonne della matrice da sottocampionare
% DELAY = seleziona la posizione del campione da non scartare
%
% E = matrice di sottocampionamento
%
function E = matrix_downsamp_col(D, M, N, delay)
if floor(N/D)*D == N
    K = N/D;
else
    disp('Error column downsampling: number of rows not a multiple of downsampling factor');
    return
end
E = sparse([zeros(1,delay) 1 zeros(1,D-1-delay)]);
E = kron(speye(K), E);
E = kron(E, speye(M));
end
