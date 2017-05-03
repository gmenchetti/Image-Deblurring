% Crea la matrice di filtraggio 2D di una immagine con filtro separabile
% per righe e colonne
%
% A = MATRIX_FILTER2D_SEP( HC, HR, EXT, M, N, TC, TR )
%
% HC = coefficienti del filtro per colonne
% HR = coefficienti del filtro per righe
% EXT = variabile carattere per il tipo di estensione al bordo
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = estensione periodica
% M = numero di righe della matrice da filtrare
% N = numero di colonne della matrice da filtrare
% TC = traslazione (periodica) filtraggio per colonne (solo se ext = 'p')
% TR = traslazione (periodica) filtraggio per righe (solo se ext = 'p')
% 
%
% A = matrice di filtraggio 2D
%
function A = matrix_filter2D_sep( hc, hr, ext, M, N, tc, tr )
% il calcolo usa sempre la stessa matrice per non sprecare memoria

% calcolo matrice di filtraggio per colonne
A = matrix_filter_col( hc, ext, M, N, tc );

% calcolo matrice di filtraggio per righe
A = matrix_filter_row( hr, ext, M, N, tr ) * A;

end
