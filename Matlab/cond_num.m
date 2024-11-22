clc;clear;close all

%% problems in fp number systems
x = -50:0.1:50;
y = cosh(x).^2-sinh(x).^2;

figure

plot(x,y,'-b',LineWidth=2)

xlim([-55,55])
ylim([-1,3])


%% condition number
% generate a random matrix
matrix_size = 10;
A =  randn(matrix_size);
b = randn(matrix_size,1);
[u,s,v] = svd(A);
% set smallest singular value to 1
s = s/min(diag(s));


%% condition number 10^3

fprintf('\ncondition number \t error\n')

for scale = 0:3:15
    s(1,1) = 10^scale;
    A = u*s*v';
    x = A\b;
    err = norm(A*x-b);
    fprintf('%.2e\t\t %.2e\n',s(1,1),err)
end

