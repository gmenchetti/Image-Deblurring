% Crea la matrice di decomposizione wavelet 2D decimata (separabile)
% di una immagine
%
% WD = MATRIX_DWT2D_ANALYSIS( W_TYPE, J, M, N )
%
% W_TYPE = tipo di wavelet. Esempi testati:
%         'bior4.4'
%         'db4'
% J = numero di livelli di decomposizione
% M = numero di righe della matrice da filtrare
% N = numero di colonne della matrice da filtrare
%
% WD = matrice di decomposizione
%
function WD = matrix_dwt2D_analysis( w_type, J, M, N )
% carico i filtri di decomposizione wavelet
[Lo_D,Hi_D,~,~] = wfilters(w_type);
if strcmp(w_type, 'bior4.4')
    ext = 'o';
    delay = 1;
    % seleziono coefficienti non nulli
    Lo_D = Lo_D(2:end);
    Hi_D = Hi_D(2:end-2);
elseif strcmp(w_type, 'db4')
    ext = 'p';
    delay = 0;
end

% Calcolo meta' della lunghezza dei filtri
N_Hi_D = length(Hi_D);
if iseven(N_Hi_D)
    N2_Hi_D = N_Hi_D/2;
else
    N2_Hi_D = (N_Hi_D-1)/2;
end
N_Lo_D = length(Lo_D);
if iseven(N_Lo_D)
    N2_Lo_D = N_Lo_D/2;
else
    N2_Lo_D = (N_Lo_D-1)/2;
end

% inizializzo matrice di uscita e matrice passabasso
WD = sparse([]);
LL = speye(M*N);

% ciclo di calcolo matrici di decomposizione wavelet ai vari livelli
for j=1:J
    
    % Calcolo le matrici di decomposizione wavelet
    % Attenzione: quando il filtraggio passa-alto e' per colonne
    % il ritardo nel sottocampionamento e' sulle righe e viceversa
    
    % Matrice HH
    WD = [matrix_downsamp2D(2, 2, M/2^(j-1), N/2^(j-1), delay, delay) ...
        * matrix_filter2D_sep( Hi_D, Hi_D, ext, M/2^(j-1), N/2^(j-1), N2_Hi_D, N2_Hi_D ) ...
        * LL; WD];
    % Matrice HL
    WD = [matrix_downsamp2D(2, 2, M/2^(j-1), N/2^(j-1), 0, delay) ...
        * matrix_filter2D_sep( Hi_D, Lo_D, ext, M/2^(j-1), N/2^(j-1), N2_Hi_D, N2_Lo_D ) ...
        * LL; WD];
    %Matrice LH
    WD = [matrix_downsamp2D(2, 2, M/2^(j-1), N/2^(j-1), delay, 0) ...
        * matrix_filter2D_sep( Lo_D, Hi_D, ext, M/2^(j-1), N/2^(j-1), N2_Lo_D, N2_Hi_D ) ...
        * LL; WD];
    % Matrice LL
    LL = matrix_downsamp2D(2, 2, M/2^(j-1), N/2^(j-1), 0, 0) ...
        * matrix_filter2D_sep( Lo_D, Lo_D, ext, M/2^(j-1), N/2^(j-1), N2_Lo_D, N2_Lo_D ) ...
        *LL;
    % se siamo all'ultimo livello aggiungo matrice LL
    if j == J
        WD = [LL; WD];
    end
end

end
