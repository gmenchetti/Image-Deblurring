
% carico immagine
load ../lena
M=128;
N=128;
X=lena(200:200+M-1,200:200+N-1);

% creo matrice wavelet di sintesi
J = 1;
WR = matrix_dwt2D_synthesis('bior4.4',J,M,N);
WD = matrix_dwt2D_analysis('bior4.4',J,M,N);


% creo matrice filtraggio
H = matrix_filter2D(diag(ones(1,20))/20, 'o',M,N,0,0);

% immagine con blur
xb = H*X(:);

% ricostruisco solo la parte LL e la tolgo alla immagine osservata
wxb = WD*xb(:);
xbLL = WR(:,1:M*N/4^J)*wxb(1:M*N/4^J);
y = xb-xbLL;

% creo variabili per l1_ls
WRa = WR(:,M*N/4^J+1:end);
A = H*WRa;
%At = matrix_transpose(M,N);
lambda  = 0.01; % regularization parameter
rel_tol = 0.01; % relative target duality gap
%run the l1-regularized least squares solver
%[x,status]=l1_ls(A,At,size(A,1),size(A,2),y,lambda,rel_tol);
[x,status]=l1_ls(A,y,lambda,rel_tol);

xd = xbLL+WRa*x;
