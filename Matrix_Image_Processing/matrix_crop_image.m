% Crea la matrice di crop di una immagine
%
% A = MATRIX_CROP_IMAGE( OR, OC, DR, DC, M, N )
%
% OR = offset riga
% OC = offset colonna
% DR = numero righe da selezionare
% DC = numero colonne da selezionare
% M = numero di righe della matrice da ritagliare
% N = numero di colonne della matrice da ritagliare
%
% A = matrice di cropping
%
function A = matrix_crop_image( or, oc, dr, dc, M, N )
AR = sparse([zeros(dr,or) eye(dr) zeros(dr,M-dr-or)]);
AC = sparse([zeros(dc,oc) eye(dc) zeros(dc,N-dc-oc)]);
A = kron(AC, AR);
end
