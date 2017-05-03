% Stima la lunghezza della PSF dopo aver stimato l'angolo theta
% 
% length = length_estimation(X, theta)
% 
% X = IMMAGINE BLUR
% theta = ANGOLO STIMATO
% 
% length = LUNGHEZZA STIMATA
function length = length_estimation(X, theta)
    [M, N] = size(X);
    %% Creo la finestra di Hann
    mask = zeros(M, N);
    for i = 1:N
        mask(:, i) = hann(M);
    end
    mask = mask.*mask';
    
    %% Spettro di potenza e trasformata Radon
    transform = fftshift(fft2(X.*mask));
    power = log(1 + abs(transform));
    rad = radon(power, theta);
    figure, plot(rad), title('Radon transform in Theta');
    
    %% Metodo basato sui minimi
    [m, index] = max(rad); 
    st = index;
    [local_values, indexes] = findpeaks(-(rad(st:end, :)));
    me = indexes(1,1);
    for i = 2:size(indexes, 1)
        me = me + (indexes(i, 1) - indexes(i-1, 1));
    end
    me = me/(size(indexes, 1)-1);
    length = N/me;
end

