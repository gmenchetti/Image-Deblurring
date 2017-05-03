% Crea la matrice di sovracampionamento per righe di una immagine
%
% E = MATRIX_UPSAMP_ROW( D, M, N, DELAY )
%
% D = fattore di sovracampionamento
% M = numero di righe della matrice da sovracampionare
% N = numero di colonne della matrice da sovracampionare
% DELAY = seleziona dove posizionare gli zeri di interpolazione
%
% E = matrice di sovracampionamento
%
function E = matrix_upsamp_row(D, M, N, delay)
E = sparse([zeros(delay, 1); 1; zeros(D-1-delay,1)]);
E = kron(speye(M), E);
E = kron(speye(N), E);
end
