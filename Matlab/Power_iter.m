clear;close all;clc;



A = [2 3 -2;3 1 0; -3 -3 3];


% rng(1000)
% A = randn(3);


fprintf(' A = \n');
fprintf(' %.4f %.4f %.4f\n',A');

[v,d] = eig(A);

fprintf('\n\n==========Eigen values================\n\n');

fprintf('\n v = \t\t\t\t\t d=\n');
fprintf('%.4f %.4f %.4f \t\t %.4f %.4f %.4f\n',[v';d']);

fprintf('\n\n==========Power Iteration================\n\n');

AA = A;


x = [0;0;1];
%x = randn(3,1)

for iter = 1:10
    
    xold = x;
    x = AA*x;
    x = x/norm(x);
    
    
    fprintf('%.4f %.4f %.4f \n',x');
%     
%     if norm(x-xold) <=1e-6
%         fprintf('\n\t threshold reached at %i-th iteration\n',iter)
%         break;
%     end
%         

end
