% Crea la matrice di sottocampionamento 2D di una immagine
%
% E = MATRIX_DOWNSAMP2D( DC, DR, M, N, DELAYC, DELAYR )
%
% DC = fattore di sottocampionamento per le colonne
% DR = fattore di sottocampionamento per le righe
% M = numero di righe della matrice da sottocampionare
% N = numero di colonne della matrice da sottocampionare
% DELAYC = seleziona la posizione delle colonne da non scartare
% DELAY = seleziona la posizione delle righe da non scartare
%
% E = matrice di sottocampionamento
%
function E = matrix_downsamp2D(DC, DR, M, N, delayc, delayr)

% sottocampionamento delle colonne
E = matrix_downsamp_col(DC, M, N, delayc);

% sottocampionamento delle righe
E_r = matrix_downsamp_row(DR, M, N/DC, delayr);

E = E_r*E;
end
