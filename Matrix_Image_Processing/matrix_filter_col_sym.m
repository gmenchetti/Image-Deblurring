% Crea la matrice di filtraggio di una immagine per colonne
%
% A = matrix_filter_col_sym( H, M, N )
%
% H = coefficienti del filtro
% M = numero di righe della matrice da filtrare
% N = numero di colonne della matrice da filtrere
%
% A = matrice di filtraggio
%
function A = matrix_filter_col_sym( h, M, N )
% impongo al vettore h di essere riga e lo inverto temporalmente
h = h(:);
h = h.';
h = fliplr(h);

% calcolo dimensioni filtro
Nh = length(h);
if iseven(Nh)
    Nh2 = Nh/2;
else
    Nh2 = (Nh-1)/2;
end

% calcolo la matrice di filtraggio di una singola colonna:
if iseven(Nh)
    B = sparse(toeplitz([h(1); zeros(M-1,1)],[h zeros(1,M)]));
else
    B = sparse(toeplitz([h(1); zeros(M-1,1)],[h zeros(1,M-1)]));
end

% estensione ai bordi
if iseven(Nh)
% simmetrica con ripetizione di campione
    B(:,Nh2+1:Nh) = B(:,Nh2+1:Nh) + fliplr(B(:,1:Nh2));
    B(:,end-Nh+1:end-Nh2) = B(:,end-Nh+1:end-Nh2) + fliplr(B(:,end-Nh2+1:end));
else
% simmetrica senza ripetizione di campione
    B(:,Nh2+2:Nh) = B(:,Nh2+2:Nh) + fliplr(B(:,1:Nh2));
    B(:,end-Nh+1:end-1-Nh2) = B(:,end-Nh+1:end-1-Nh2) + fliplr(B(:,end-Nh2+1:end));
end
B = B(:,Nh2+1:end-Nh2);

% creo la matrice di filtraggio a blocchi per tutte le colonne
% A = kronecker(I,B)
A = kron(speye(N),B);

end

