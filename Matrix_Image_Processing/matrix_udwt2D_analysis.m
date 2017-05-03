% Crea la matrice di decomposizione wavelet 2D non decimata (separabile)
% di una immagine
%
% W = MATRIX_UDWT2D_ANALYSIS( W_TYPE, J, M, N )
%
% W_TYPE = tipo di wavelet. Esempi testati:
%         'bior4.4'
%         'db4'
% J = numero di livelli di decomposizione
% M = numero di righe della matrice da filtrare
% N = numero di colonne della matrice da filtrare
%
% W = matrice di decomposizione
%
function W = matrix_udwt2D_analysis( w_type, J, M, N )
% carico i filtri di decomposizione wavelet
[Lo_D,Hi_D,~,~] = wfilters(w_type);
if strcmp(w_type, 'bior4.4')
    ext = 'o';
    % normalizzazione per guadagno unitario
    Lo_D = Lo_D(2:end)/sqrt(2);
    Hi_D = Hi_D(2:end-2)/sqrt(2);
elseif strcmp(w_type, 'db4')
    ext = 'p';
    % normalizzazione per guadagno unitario
    Lo_D = Lo_D/sqrt(2);
    Hi_D = Hi_D/sqrt(2);
end

% ciclo di calcolo matrici di decomposizione wavelet ai vari livelli
W = sparse([]);
for j=1:J
    % calcolo filtri equivalenti
    Lo_Dj = 1;
    for k=1:j-1
        Lo_Dj = conv(upsamp(Lo_D,2^(k-1)),Lo_Dj);
    end
    Hi_Dj = conv(upsamp(Hi_D,2^(j-1)),Lo_Dj);
    Lo_Dj = conv(upsamp(Lo_D,2^(j-1)),Lo_Dj);

    % Calcolo meta' della lunghezza dei filtri
    N_Hi_Dj = length(Hi_Dj);
    if iseven(N_Hi_Dj)
        N2_Hi_Dj = N_Hi_Dj/2;
    else
        N2_Hi_Dj = (N_Hi_Dj-1)/2;
    end
    N_Lo_Dj = length(Hi_Dj);
    if iseven(N_Lo_Dj)
        N2_Lo_Dj = N_Lo_Dj/2;
    else
        N2_Lo_Dj = (N_Lo_Dj-1)/2;
    end
        
    % aggiungo matrice HH
    W = [matrix_filter2D_sep(Hi_Dj, Hi_Dj, ext, M, N, N2_Hi_Dj, N2_Hi_Dj); W];
    % aggiungo matrice HL
    W = [matrix_filter2D_sep(Hi_Dj, Lo_Dj, ext, M, N, N2_Hi_Dj, N2_Lo_Dj); W];
    % aggiungo matrice LH
    W = [matrix_filter2D_sep(Lo_Dj, Hi_Dj, ext, M, N, N2_Lo_Dj, N2_Hi_Dj); W];
    % se siamo all'ultimo livello aggiungo matrice LL
    if j == J
        W = [matrix_filter2D_sep(Lo_Dj, Lo_Dj, ext, M, N, N2_Lo_Dj, N2_Lo_Dj); W];
    end
end

end
