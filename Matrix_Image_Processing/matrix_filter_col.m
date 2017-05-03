% Crea la matrice di filtraggio di una immagine per colonne
%
% A = MATRIX_FILTER_COL( H, EXT, M, N, TC )
%
% H = coefficienti del filtro
% EXT = variabile carattere per il tipo di estensione al bordo
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = periodica
% M = numero di righe della matrice da filtrare
% N = numero di colonne della matrice da filtrere
% TC = traslazione (periodica) filtraggio per colonne (solo se ext = 'p')
%
% A = matrice di filtraggio
%
function A = matrix_filter_col( h, ext, M, N, tc )

% calcolo lunghezza del filtro
Nh = length(h);
if iseven(Nh)
    Nh2 = Nh/2;
else
    Nh2 = (Nh-1)/2;
end

% impongo al vettore h di essere riga e lo inverto temporalmente
h = h(:);
h = h.';
h = fliplr(h);

% estendo l'immagine
if ext == 'z'
    % inserisco zeri in alto
    A = matrix_extend_borders_up( Nh-1, ext, M, N );
elseif ext == 'e'
    % estensione pari in alto (Nh2) e in basso (Nh-1-Nh2)
    A = matrix_extend_borders_up( Nh2, ext, M, N );
    A = matrix_extend_borders_down( Nh-Nh2-1, ext, M+Nh2, N ) * A;
elseif ext == 'o'
    % estensione dispari in alto (Nh2) e in basso (Nh-1-Nh2)
     A = matrix_extend_borders_up( Nh2, ext, M, N );
     A = matrix_extend_borders_down( Nh-Nh2-1, ext, M+Nh2, N ) * A;
elseif ext == 'p'
    % estensione periodica in alto (Nh-1 campioni)
      A = matrix_extend_borders_up( Nh-1, ext, M, N );
end

% calcolo la matrice di filtraggio di una singola colonna
B = sparse(toeplitz([h(1); zeros(M-1,1)],[h zeros(1,M-1)]));

% espando (a blocchi) per tutte le colonne e la applico alla
% immagine estesa
A = kron(speye(N),B)*A;

% traslo circolarmente l'immagine (solo per estensione periodica)
if ext == 'p' && tc ~=0
    A = matrix_circ_shift_up(tc, M, N) * A;
end
end
