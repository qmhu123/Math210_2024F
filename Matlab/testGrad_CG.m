clear;
close all
clc

%% parameter settings
% 1 for Gaussian
% 2 for DCT
% 3 for Loop Laplacian
% matrixtype = 1;
M = 2;     % matrix dimension M-by-N
K = 2 ;             % sparsity
rng(3000);


%% construct sensing matrix
% A   = rand(M); % Gaussian matrix
% A   = A'*A;
A = 2*eye(2);
A(2) = -0.1;
A(3) = A(2);
xs = randn(K,1);
x_ref = xs;
x0 = 20*randn(K,1);


%% construct sparse ground-truth

b_gt = A*x_ref;
SNR = 30;
SNR12 = 10^(SNR/10);
N = length(b_gt);

% Standard Deviation of noise
% noise_Var = (sum(b_gt.^2) / SNR12 / N );
% noise_std = sqrt(noise_Var);
% noise_real = noise_std * randn(N,1);
% 
% b = b_gt + noise_real;
% Snr = snr(b_gt,noise_real);

b = b_gt; 
pm.b_gt = b_gt;
pm.xg = x_ref;
pm.reltol = 1e-16;
pm.x0 = x0;

%% 30dB
% [xCG, outputCG] = Linear_Conj_Grad(A,b,pm);
[xGD, outputGD] = Linear_Grad_Descent(A,b,pm);

%% for actual calculation

% pwr = 2.^[-1:0.5:3];
% [xx, yy] = meshgrid([-pwr,pwr]);

[xx,yy] = meshgrid(-10:0.1:25);
zz = xx.^2 * A(1,1) + xx.*yy.*(A(1,2)+A(2,1)) + yy.^2 * A(2,2);


l = size(outputGD.xt,2);
xt = zeros(l+1,2);
xt(1,:) = x0;
for idx = 1:l
    xt(idx+1,:) = outputGD.xt{idx};
end

figure
contour(xx,yy,zz,LevelList=[0:10,15:5:50,50:50:800,800:100:2400]);

hold on
plot(x_ref(1),x_ref(2),'ro')
plot(x0(1),x0(2),'bo')
% plot(xt(:,1),xt(:,2),'-*r',LineWidth=2)

for idx = 1:l
    plot(xt(1:idx,1),xt(1:idx,2),'-*r',LineWidth=2)
    drawnow
end
