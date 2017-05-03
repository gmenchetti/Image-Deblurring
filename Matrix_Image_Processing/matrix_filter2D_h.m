% Crea la matrice di filtraggio 2D di una immagine
% da applicare ad una risposta impulsiva non separabile
%
% B = MATRIX_FILTER_2D_H( X, EXT, MH, NH, TC, TR )
%
% X = immagine da filtrare
% EXT = variabile carattere per il tipo di estensione al bordo
%      'e' = estensione pari
%      'o' = estensione dispari
%      'z' = zero padding
%      'p' = periodica
% M = numero di righe della risposta impulsiva
% N = numero di colonne della risposta impulsiva
% TC = traslazione (periodica) filtraggio per colonne (solo se ext = 'p')
% TR = traslazione (periodica) filtraggio per righe (solo se ext = 'p')
%
% B = matrice di filtraggio
%
function B = matrix_filter2D_h( x, ext, Mh, Nh, tc, tr)

% calcolo lunghezza del filtro
[Mx Nx] = size(x);
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


% estendo l'immagine
if ext == 'z' || ext == 'p'
    % inserisco zeri in alto e a sinistra
    A = matrix_extend_borders_up( Mh-1, ext, Mx, Nx );
    A = matrix_extend_borders_left( Nh-1, ext, Mx+Mh-1, Nx ) * A;
    miniz = Mh-1;
    niniz = Nh-1;
elseif ext == 'e' || ext == 'o'
    % estensione pari (o dispari) in alto (Mh2) e in basso (Mh-1-Mh2)
    % a sinistra (Nh2) e a destra (Nh-1-Nh2)
    A = matrix_extend_borders_up( Mh2, ext, Mx, Nx );
    A = matrix_extend_borders_down( Mh-Mh2-1, ext, Mx+Mh2, Nx ) * A;
    A = matrix_extend_borders_left( Nh2, ext, Mx+Mh-1, Nx ) * A;
    A = matrix_extend_borders_right( Nh-Nh2-1, ext, Mx+Mh-1, Nx+Nh2 ) * A;
    % elseif ext == 'o'
    %     % estensione dispari in alto (Nh2) e in basso (Nh-1-Nh2)
    %     A = matrix_extend_borders_up( Mh2, ext, M, N );
    %     A = matrix_extend_borders_down( Mh-Mh2-1, ext, M+Mh2, N ) * A;
    %     A = matrix_extend_borders_left( Nh2, ext, M+Nh-1, N ) * A;
    %     A = matrix_extend_borders_left( Nh-Nh2-1, ext, M+Nh-1, N+Nh2 ) * A;
    % elseif ext == 'p'
    %     % estensione periodica in alto (Nh-1 campioni)
    %       A = matrix_extend_borders_up( Nh-1, ext, M, N );
    miniz = Mh2;
    niniz = Nh2;
end
x = A*x(:);
x = reshape(x,Mx+Mh-1,Nx+Nh-1);

% calcolo la matrice di filtraggio
B = zeros(Mx*Nx,Mh*Nh);
for n = 1:Nx
    for m = 1:Mx;
        x1 = x(m:m+Mh-1,n:n+Nh-1);
        % inverto il filtro spazialmente
        x1 = fliplr(x1);
        x1 = flipud(x1);
        B((n-1)*Nx+m,:) = x1(:).';
    end
end


% traslo circolarmente l'immagine (solo per estensione periodica)
if ext == 'p'
    if tc ~=0
        B = matrix_circ_shift_left(tc, Mx, Nx) * B;
    elseif tr ~=0
        B = matrix_circ_shift_up(tr, Mx, Nx) * B;
    end
end

end
