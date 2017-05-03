% Crea la matrice di filtraggio di una immagine per righe
%
% A = MATRIX_FILTER_ROW( H, EXT, M, N, TR )
%
% H = coefficienti del filtro
% EXT = variabile carattere per il tipo di estensione al bordo
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = periodica
% M = numero di righe della matrice da filtrare
% N = numero di colonne della matrice da filtrere
% TR = traslazione (periodica) filtraggio per righe (solo se ext = 'p')
%
% A = matrice di filtraggio
%
function A = matrix_filter_row( h, ext, M, N, tr )

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
    % inserisco zeri a sinistra
    A = matrix_extend_borders_left( Nh-1, ext, M, N );
elseif ext == 'e'
    % estensione pari a sinistra (Nh2) e a destra (Nh-1-Nh2)
    A = matrix_extend_borders_left( Nh2, ext, M, N );
    A = matrix_extend_borders_right( Nh-Nh2-1, ext, M, N+Nh2 ) * A;
elseif ext == 'o'
    % estensione dispari a sinistra (Nh2) e a destra (Nh-1-Nh2)
     A = matrix_extend_borders_left( Nh2, ext, M, N );
     A = matrix_extend_borders_right( Nh-Nh2-1, ext, M, N+Nh2 ) * A;
elseif ext == 'p'
    % estensione periodica a sinistra (Nh-1 campioni)
      A = matrix_extend_borders_left( Nh-1, ext, M, N );
end

% calcolo la matrice di filtraggio di una singola riga
B = sparse(toeplitz([h(1); zeros(N-1,1)],[h zeros(1,N-1)]));

% espando (a blocchi) per tutte le righe e la applico alla immagine estesa
A = kron(B,speye(M)) * A;

% traslo circolarmente l'immagine (solo per estensione periodica)
if ext == 'p' && tr ~=0
    A = matrix_circ_shift_left(tr, M, N) * A;
end

end
