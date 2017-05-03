% Crea la matrice di sovracampionamento 2D di una immagine
%
% E = MATRIX_DOWNSAMP2D( DC, DR, M, N, DELAYC, DELAYR )
%
% DC = fattore di sovracampionamento per le colonne
% DR = fattore di sovracampionamento per le righe
% M = numero di righe della matrice da sovracampionare
% N = numero di colonne della matrice da sovracampionare
% DELAYC = seleziona la posizione delle colonne da mantenere
% DELAY = seleziona la posizione delle righe da mantenere
%
% E = matrice di sovracampionamento
%
function E = matrix_upsamp2D(DC, DR, M, N, delayc, delayr)

% sovracampionamento delle colonne
E = matrix_upsamp_col(DC, M, N, delayc);

% sovracampionamento delle righe
E = matrix_upsamp_row(DR, M, N*DC, delayr) * E;

end
