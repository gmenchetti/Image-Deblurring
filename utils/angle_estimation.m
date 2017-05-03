% Stima l'angolo della PSF
% 
% theta = angle_estimation(X)
% 
% X = IMMAGINE BLUR
% 
% theta = ANGOLO STIMATO

function theta = angle_estimation(X)
    [M, N] = size(X);   
    %% Creo la finestra di Hann
    mask = zeros(M, N);
    for i = 1:N
        mask(:, i) = hann(M);
    end
    mask = mask.*mask';
    
    %% Spettro di potenza e la trasformata Radon
    transform = fftshift(fft2(X.*mask));
    power = log(1 + abs(transform));
    figure, imshow(power), title('Power Spectrum');
    angles = 0:179;
    rad = radon(power, angles);
    
    %% Calcolo l'angolo
    variance = var(rad);
    [m, theta] = max(variance);
end