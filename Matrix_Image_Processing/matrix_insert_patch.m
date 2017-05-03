% Crea la matrice di inserimento di una patch in una immagine
%
% A = MATRIX_INSERT_PATCH( OR, OC, DR, DC, M, N )
%
% OR = offset riga
% OC = offset colonna
% DR = numero righe patch
% DC = numero colonne patch
% M = numero di righe della immagine in cui inserire patch
% N = numero di colonne della immagine in cui inserire patch
%
% A = matrice di inserimento
%
function A = matrix_insert_patch( or, oc, dr, dc, M, N )
AR = sparse([zeros(or,dr); eye(dr); zeros(M-dr-or,dr)]);
AC = sparse([zeros(oc,dc); eye(dc); zeros(N-dc-oc,dc)]);
A = kron(AC, AR);
end
