% Crea la matrice di filtraggio 2D (non separabile) di una immagine
%
% A = MATRIX_FILTER_COL( H, EXT, M, N, TC, TR )
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
% TR = traslazione (periodica) filtraggio per righe (solo se ext = 'p')
%
% A = matrice di filtraggio
%
function A = matrix_filter2D( h, ext, M, N, tc, tr )

% calcolo lunghezza del filtro
[Mh Nh] = size(h);
if iseven(Mh)
    Mh2 = Mh/2;
else
    Mh2 = (Mh-1)/2;
end
if iseven(Nh)
    Nh2 = Nh/2;
else
    Nh2 = (Nh-1)/2;
end

% inverto il filtro spazialmente
h = fliplr(h);
h = flipud(h);

% estendo l'immagine
if ext == 'z' || ext == 'p'
    % inserisco zeri in alto e a sinistra
    A = matrix_extend_borders_up( Mh-1, ext, M, N );
    A = matrix_extend_borders_left( Nh-1, ext, M+Mh-1, N ) * A;
elseif ext == 'e' || ext == 'o'
    % estensione pari (o dispari) in alto (Mh2) e in basso (Mh-1-Mh2)
    % a sinistra (Nh2) e a destra (Nh-1-Nh2)
    A = matrix_extend_borders_up( Mh2, ext, M, N );
    A = matrix_extend_borders_down( Mh-Mh2-1, ext, M+Mh2, N ) * A;
    A = matrix_extend_borders_left( Nh2, ext, M+Mh-1, N ) * A;
    A = matrix_extend_borders_right( Nh-Nh2-1, ext, M+Mh-1, N+Nh2 ) * A;
    % elseif ext == 'o'
    %     % estensione dispari in alto (Nh2) e in basso (Nh-1-Nh2)
    %     A = matrix_extend_borders_up( Mh2, ext, M, N );
    %     A = matrix_extend_borders_down( Mh-Mh2-1, ext, M+Mh2, N ) * A;
    %     A = matrix_extend_borders_left( Nh2, ext, M+Nh-1, N ) * A;
    %     A = matrix_extend_borders_left( Nh-Nh2-1, ext, M+Nh-1, N+Nh2 ) * A;
    % elseif ext == 'p'
    %     % estensione periodica in alto (Nh-1 campioni)
    %       A = matrix_extend_borders_up( Nh-1, ext, M, N );
end

% calcolo la matrice di filtraggio
B = sparse(M*N,(M+Mh-1)*(N+Nh-1));
for k=1:Nh
    B1 = sparse(toeplitz([h(1,k); zeros(M-1,1)], [h(:,k)' zeros(1,M-1)]));
    A1 = sparse([zeros(N,k-1) eye(N) zeros(N,Nh-k)]);
    B = B + kron(A1, B1);
end

% moltiplico per matrice di estensione
A = B*A;

% traslo circolarmente l'immagine (solo per estensione periodica)
if ext == 'p'
    if tc ~=0
        A = matrix_circ_shift_left(tc, M, N) * A;
    elseif tr ~=0
        A = matrix_circ_shift_up(tr, M, N) * A;
    end
end

end
