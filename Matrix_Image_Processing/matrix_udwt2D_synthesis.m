% Crea la matrice di ricostruzione wavelet 2D non decimata (separabile)
% di una immagine
%
% W = MATRIX_UDWT2D_SYNTHESIS( W_TYPE, J, M, N )
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
function W = matrix_udwt2D_synthesis( w_type, J, M, N )
% carico i filtri di decomposizione wavelet
[~,~,Lo_R,Hi_R] = wfilters(w_type);
if strcmp(w_type, 'bior4.4')
    ext = 'o';
    % normalizzazione per guadagno unitario
    Lo_R = Lo_R(2:end-2)/sqrt(2);
    Hi_R = Hi_R(2:end)/sqrt(2);
elseif strcmp(w_type, 'db4')
    ext = 'p';
    % normalizzazione per guadagno unitario
    Lo_R = Lo_R/sqrt(2);
    Hi_R = Hi_R/sqrt(2);
end

% ciclo di calcolo matrici di decomposizione wavelet ai vari livelli
W = sparse([]);
for j=1:J
    % calcolo filtri equivalenti
    Lo_Rj = 1;
    for k=1:j-1
        Lo_Rj = conv(upsamp(Lo_R,2^(k-1)),Lo_Rj);
    end
    Hi_Rj = conv(upsamp(Hi_R,2^(j-1)),Lo_Rj);
    Lo_Rj = conv(upsamp(Lo_R,2^(j-1)),Lo_Rj);

    % Calcolo meta' della lunghezza dei filtri
    N_Hi_Rj = length(Hi_Rj);
    if iseven(N_Hi_Rj)
        N2_Hi_Rj = N_Hi_Rj/2;
    else
        N2_Hi_Rj = (N_Hi_Rj-1)/2;
    end
    N_Lo_Rj = length(Hi_Rj);
    if iseven(N_Lo_Rj)
        N2_Lo_Rj = N_Lo_Rj/2;
    else
        N2_Lo_Rj = (N_Lo_Rj-1)/2;
    end

    % aggiungo matrice HH
    W = [matrix_filter2D_sep(Hi_Rj, Hi_Rj, ext, M, N, N_Hi_Rj-N2_Hi_Rj-1, N_Hi_Rj-N2_Hi_Rj-1) W];
    % aggiungo matrice HL
    W = [matrix_filter2D_sep(Hi_Rj, Lo_Rj, ext, M, N, N_Hi_Rj-N2_Hi_Rj-1, N_Lo_Rj-N2_Lo_Rj-1) W];
    % aggiungo matrice LH
    W = [matrix_filter2D_sep(Lo_Rj, Hi_Rj, ext, M, N, N_Lo_Rj-N2_Lo_Rj-1, N_Hi_Rj-N2_Hi_Rj-1) W];
    % se siamo all'ultimo livello aggiungo matrice LL
    if j == J
        W = [matrix_filter2D_sep(Lo_Rj, Lo_Rj, ext, M, N, N_Lo_Rj-N2_Lo_Rj-1, N_Lo_Rj-N2_Lo_Rj-1) W];
    end
end

end
