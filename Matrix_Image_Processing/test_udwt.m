% test decomposizione/ricostruzione wavelet decimata

% lettura immagine originale 

load woman
X = X(65:65+127,65:65+127);
N = 128;
M = N;
y = reshape(X,numel(X),1);

% definizione matrici di decomposizione/ricostruzione wavelet

J = 2;
%w_type = 'bior4.4';
w_type = 'db4';
disp('Inizio calcolo matrice udwt analisi')
WD = matrix_udwt2D_analysis( w_type, J, M, N );

disp('Inizio calcolo matrice udwt sintesi')
WR = matrix_udwt2D_synthesis( w_type, J, M, N );

disp('Trasformata diretta')
b = WD*y;

disp('Trasformata inversa')
b = WR*b;

b = reshape(b,N,M);
figure, imshow(X/255);
figure, imshow(b/255);

max(max(abs(X-b)))