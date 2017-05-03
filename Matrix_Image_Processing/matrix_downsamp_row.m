% Crea la matrice di sottocampionamento per righe di una immagine
%
% E = MATRIX_DOWNSAMP_ROW( D, M, N, DELAY )
%
% D = fattore di sottocampionamento
% M = numero di righe della matrice da sottocampionare
% N = numero di colonne della matrice da sottocampionare
% DELAY = seleziona la posizione del campione da non scartare
%
% E = matrice di sottocampionamento
%
function E = matrix_downsamp_row(D, M, N, delay)
if floor(M/D)*D == M
    K = M/D;
else
    disp('Error row downsampling: number of rows not a multiple of downsampling factor');
    return
end
E = sparse([zeros(1,delay) 1 zeros(1,D-1-delay)]);
E = kron(speye(K), E);
E = kron(speye(N), E);
end
