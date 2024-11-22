clear;clc;close all

fid = fopen('QR_iter_example.txt','w');

A = [1 1 0 -1;1 3 0 1;4 2 2 0;0 1 1 1]';


[m,n] = size(A);
Q = zeros(m,n);
R = zeros(n,n);
fprintf('\n')
for j = 1:n
    v = A(:,j);
    for i = 1:j-1
        R(i,j) = Q(:,i)'*A(:,j);
        fprintf('\t%.4f\t',R(i,j))
        v=v-R(i,j)*Q(:,i);
    end
    R(j,j) = norm(v);
    fprintf('\n%.4f\n',R(j,j)^2)
    disp(v')
    Q(:,j) = v/R(j,j);
end

