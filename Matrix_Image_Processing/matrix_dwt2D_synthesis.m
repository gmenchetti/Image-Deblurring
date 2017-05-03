% Crea la matrice di ricostruzione wavelet 2D decimata (separabile)
% di una immagine
%
% W = MATRIX_DWT2D_SYNTHESIS( W_TYPE, J, M, N )
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
function WR = matrix_dwt2D_synthesis( w_type, J, M, N )
% carico i filtri di ricostruzione wavelet
[~,~,Lo_R,Hi_R] = wfilters(w_type);
if strcmp(w_type, 'bior4.4')
    ext = 'o';
    delay = 1;
    % estraggo coefficienti non nulli
    Lo_R = Lo_R(2:end-2);
    Hi_R = Hi_R(2:end);
elseif strcmp(w_type, 'db4')
    ext = 'p';
    delay = 0;
end

% Calcolo meta' della lunghezza dei filtri
N_Hi_R = length(Hi_R);
if iseven(N_Hi_R)
    N2_Hi_R = N_Hi_R/2;
else
    N2_Hi_R = (N_Hi_R-1)/2;
end
N_Lo_R = length(Lo_R);
if iseven(N_Lo_R)
    N2_Lo_R = N_Lo_R/2;
else
    N2_Lo_R = (N_Lo_R-1)/2;
end

% inizializzo matrice di uscita e matrice passabasso
WR = sparse([]);
LL = speye(M*N);

% ciclo di calcolo matrici di decomposizione wavelet ai vari livelli
for j=1:J

    % Calcolo le matrici di ricostruzione wavelet
    % Attenzione: quando il filtraggio passa-alto e' per colonne
    % il ritardo nel sottocampionamento e' sulle righe e viceversa
    
    % Matrice HH
    WR = [ LL * matrix_filter2D_sep( Hi_R, Hi_R, ext, M/2^(j-1), N/2^(j-1), N_Hi_R-1-N2_Hi_R, N_Hi_R-1-N2_Hi_R ) ...
        * matrix_upsamp2D(2, 2, M/2^j, N/2^j, delay, delay) WR];
    % Matrice HL
    WR = [ LL * matrix_filter2D_sep( Hi_R, Lo_R, ext, M/2^(j-1), N/2^(j-1), N_Hi_R-1-N2_Hi_R, N_Lo_R-1-N2_Lo_R ) ...
        * matrix_upsamp2D(2, 2, M/2^j, N/2^j, 0, delay) WR];
    % Matrice LH
    WR = [ LL * matrix_filter2D_sep( Lo_R, Hi_R, ext, M/2^(j-1), N/2^(j-1), N_Lo_R-1-N2_Lo_R, N_Hi_R-1-N2_Hi_R ) ...
        * matrix_upsamp2D(2, 2, M/2^j, N/2^j, delay, 0) WR];
    % Matrice LL
    LL =  LL * matrix_filter2D_sep( Lo_R, Lo_R, ext, M/2^(j-1), N/2^(j-1), N_Lo_R-1-N2_Lo_R, N_Lo_R-1-N2_Lo_R ) ...
        * matrix_upsamp2D(2, 2, M/2^j, N/2^j, 0, 0);
    % se siamo all'ultimo livello aggiungo matrice LL
    if j == J
        WR = [LL WR];
    end
end

end
