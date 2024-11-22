clear;clc;close all;
% U = [1 -1;1 1]/sqrt(2);
% E = 3*[sqrt(3) 0 0;0 1 0];
% v1 = [1 2 1]/sqrt(6);
% v2 = [-1 0 1]/sqrt(2);
% v3 = [1,-1,1]/sqrt(3);
% V = [v1;v2;v3]';
% disp(U*E*V')
% 
% A = [3 3 0;0 3 3];
% norm(A - U*E*V',"inf")

% A = [6 6;-3 3];
% [U E V] = svd(A)

% 
% U = [0 1;1 0]
% E = [sqrt(72)  0;0 sqrt(18)]
% V = [1 -1;1 1]/sqrt(2);
% 
% disp(U*E*V')


A = [1 -2;3 -6];
[U E V] = svd(A)

% U = [0 1;1 0]
% E = [sqrt(72)  0;0 sqrt(18)]
% V = [1 -1;1 1]/sqrt(2);
% 
% disp(U*E*V')