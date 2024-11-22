clc;clear;close all
x=[-0.0192 1.0889 1.9235 2.8598 3.8578 5.0488 5.9823 6.9804 8.1419 9.0292]';
y=[8.9914 8.9039 8.7906 8.6690 8.5081 8.2603 7.8108 7.0956 5.7770 3.2412]';

b0 = y(1) - 1;
b = b0;

a = zeros(7,1);


alpha = 1e-3;

beta = a;
beta(1) = b0;
beta(2:end) = 1e-3*rand(6,1);

f = @(u) beta(1) + exp(beta(2) + beta(3)*u + beta(4)*u.^2 + beta(5)*u.^3 );
% f = @(u) beta(1) + exp(beta(2) + beta(3)*u + beta(4)*u.^2 + beta(5)*u.^3 + beta(6)*u.^4+beta(7)*u.^5);

J = zeros(10,7);
J(:,1) = 1;
J(:,2:end) = kron([1;beta(3:end)]',f(x));

dy = y - f(x);

dbeta = pinv(J)*dy;

beta = beta + dbeta;
