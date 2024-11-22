clear;close all; clc

[X,Y] = meshgrid(-5:0.1:5);

%% simple parabolic surface


u = X.^2 + Y.^2;
px = 2*X.*cos(u);
py = 2*Y.*cos(u);
Z = sin(u);
lvl = -1.2:0.2:1.2;


figure
surf(X,Y,Z)
hold on
contour3(X,Y,Z,lvl,'-k',LineWidth=2) 
hold off
xlim([-2,2])
ylim([-2,2])
zlim([lvl(1),lvl(end)])


% x0 = [3;3]; % inital point
% x0 = [1.8;1.8]; % inital point
x0 = 3*rand(2,1); 

f = @(x) sin(x'*x);
pf = @(x) [2*x(1,:).*cos(x'*x);2*x(2,:).*cos(x'*x)];
hx = @(x) [2*cos(x'*x) - 4*x(1,:).^2.*sin(x'*x),-4*x(1,:).*x(2,:).*sin(x'*x);
    -4*x(1,:).*x(2,:).*sin(x'*x),2*cos(x'*x) - 4*x(2,:).^2.*sin(x'*x)];



%% Gradient descent

maxit = 1000;
x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

alpha = 0.01;
% alpha = 0.01;
tol = 1e-6;
tstart = tic;
for iter = 2:maxit
    p = pf(x_grad(:,iter-1));
    x_grad(:,iter) = x_grad(:,iter-1) - alpha*p;
    if norm(x_grad(:,iter) - x_grad(:,iter-1))<tol
        x_grad(:,iter+1:end) = [];
        break;
    end
end
tgrad = toc(tstart);

fprintf('\n=========Gradient descent===============\n')
fprintf('Converge after %i iterations\n',iter)
fprintf('Elapsed time is %.2e seconds\n',tgrad)
fprintf('The solution is [%.4f %.4f ], function value is %.4f \n',x_grad(:,end)',f(x_grad(:,end)))


figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,-px,-py)
plot(x_grad(1,:),x_grad(2,:),'-.r',LineWidth=3)
plot(x_grad(1,end),x_grad(2,end),'*',LineWidth=3)
title('gradient descent')


xlim([x0(1)-1,x0(1)+1])
ylim([x0(2)-1,x0(2)+1])

%% Newton's method/Newton Raphson 

x_newton(:,1) = x0;


tol = 1e-6;
tstart = tic;
for iter = 2:maxit
    x_newton(:,iter) = x_newton(:,iter-1) - pinv(hx(x_newton(:,iter-1)))*pf(x_newton(:,iter-1));
    if norm(x_newton(:,iter) - x_newton(:,iter-1))<tol
        x_newton(:,iter+1:end) = [];
        break;
    end
end
tgrad = toc(tstart);

fprintf("\n=========Newton's method===============\n")
fprintf('Converge after %i iterations\n',iter)
fprintf('Elapsed time is %.2e seconds\n',tgrad)
fprintf('The solution is [%.4f %.4f ],  function value is %.4f\n',x_newton(:,end)',f(x_newton(:,end)))


figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,-px,-py)
plot(x_newton(1,:),x_newton(2,:),'-.r',LineWidth=3)
plot(x_newton(1,end),x_newton(2,end),'*',LineWidth=3)
title('Newton Raphson ')
% plot()

xlim([x0(1)-1,x0(1)+1])
ylim([x0(2)-1,x0(2)+1])



%% accel
maxit = 1000;
x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;


%alpha = 
tol = 1e-6;
tstart = tic;
m = 0;
for iter = 2:maxit
    p = pf(x_grad(:,iter-1))+0.5*m;
    x_grad(:,iter) = x_grad(:,iter-1) - alpha*p;
    if norm(x_grad(:,iter) - x_grad(:,iter-1))<tol
        x_grad(:,iter+1:end) = [];
        break;
    end
    m = x_grad(:,iter) -x_grad(:,iter-1);
end
tgrad = toc(tstart);

fprintf('\n=========Gradient descent with momentum===============\n')
fprintf('Converge after %i iterations\n',iter)
fprintf('Elapsed time is %.2e seconds\n',tgrad)
fprintf('The solution is [%.4f %.4f], function value is %.4f \n',x_grad(:,end)',f(x_grad(:,end)))


figure
contour(X,Y,Z,lvl,ShowText="on")
% 
hold on
quiver(X,Y,-px,-py)
plot(x_grad(1,:),x_grad(2,:),'-r',LineWidth=3)
plot(x_grad(1,end),x_grad(2,end),'*',LineWidth=3)
% plot()

xlim([-2,2])
ylim([-2,2])