% Crea la matrice di sovracampionamento per colonne di una immagine
%
% E = MATRIX_UPSAMP_COL( D, M, N, DELAY )
%
% D = fattore di sovracampionamento
% M = numero di righe della matrice da sovracampionare
% N = numero di colonne della matrice da sovracampionare
% DELAY = seleziona dove posizionare gli zeri di interpolazione
%
% E = matrice di sovracampionamento
%
function E = matrix_upsamp_col(D, M, N, delay)
E = sparse([zeros(delay,1); 1; zeros(D-1-delay,1)]);
E = kron(speye(N), E);
E = kron(E, speye(M));
end
