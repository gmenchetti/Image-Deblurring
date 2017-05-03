% Funzione per centrare la PSF e renderla di dimensioni 32X32
%
% [ padded_PSF ] = pad_PSF( PSF )
%
% PSF
%
% padded_PSF = PSF RIPORTATA AL CENTRO
function [ padded_PSF ] = pad_PSF( PSF )
    M = 32;
    N = 32;
    [M_psf, N_psf] = size(PSF);
    pad_cols = round((N-N_psf)/2);
    PSF = [zeros(M_psf, pad_cols), PSF];
    PSF = [PSF, zeros(M_psf, pad_cols)];
    pad_rows = round((M-M_psf)/2);
    cols = size(PSF, 2);
    PSF = [zeros(pad_rows, cols); PSF];
    PSF = [PSF; zeros(pad_rows, cols)];
    if size(PSF, 1) > M
        PSF = PSF(2:end, :);
    end
    if size(PSF, 2) > N
        PSF = PSF(:, 2:end);
    end
    padded_PSF = PSF;
end

