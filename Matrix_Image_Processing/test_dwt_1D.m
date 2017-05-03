% test wavelet decomposition/reconstruction 1D

Ns = 64;
x = randi(9,Ns,1);
y = [0; x(end:-1:2); x; x(end-1:-1:1); 0];

% definizione matrici di filtraggio

% [Lo_D,Hi_D,Lo_R,Hi_R] = wfilters('bior4.4');
% Lo_D = Lo_D(2:end);
% Hi_D = Hi_D(2:end-2);
% Lo_R = Lo_R(2:end-2);
% Hi_R = Hi_R(2:end);
% ext = 'o';

[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters('db4');
ext = 'p';
Nh = 8;
Nh2 = 4;

% filtraggio non matriciale

%  L = downsamp(filter(Lo_D,1,y),2);
%  H = downsamp(filter(Hi_D,1,y),2);
% % 
%  L = filter(Lo_R,1,upsamp(L,2));
%  H = filter(Hi_R,1,upsamp(H,2));
%  
%  xr = L+H;

% Matrici di analisi
L1D = matrix_downsamp_row(2,Ns,1,0)*matrix_filter_col(Lo_D,ext,Ns,1,Nh2);
H1D = matrix_downsamp_row(2,Ns,1,0)*matrix_filter_col(Hi_D,ext,Ns,1,Nh2);
% L2D = matrix_downsamp_row(2,Ns/2,1,0)*matrix_filter_col(Lo_D,ext,Ns/2,1);
% H2D = matrix_downsamp_row(2,Ns/2,1,1)*matrix_filter_col(Hi_D,ext,Ns/2,1);
% 
% WD = [L2D*L1D; H2D*L1D; H1D];
WD = [L1D; H1D];
% 
% %Matrici di ricostruzione
% 
L1R = matrix_filter_col(Lo_R,ext,Ns,1,Nh-Nh2-1)*matrix_upsamp_row(2,Ns/2,1,0);
H1R = matrix_filter_col(Hi_R,ext,Ns,1,Nh-Nh2-1)*matrix_upsamp_row(2,Ns/2,1,0);
% L2R = matrix_filter_col(Lo_R,ext,Ns/2,1)*matrix_upsamp_row(2,Ns/4,1,0);
% H2R = matrix_filter_col(Hi_R,ext,Ns/2,1)*matrix_upsamp_row(2,Ns/4,1,1);
%  
% WR = [L1R*L2R L1R*H2R H1R];
% 
WR = [L1R H1R];
% 
 xr = WR*WD*x(:);
% 
 plot([x xr])


