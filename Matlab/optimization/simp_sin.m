clear;close all; clc

%% simple parabolic surface



x0 = [3;3]; % inital point
% x0 = 5*rand(2,1); 

f = @(x) sin(x(1,:)+x(2,:));
pf = @(x) [cos(x(1,:)+x(2,:));cos(x(1,:)+x(2,:))];
hx = @(x)(-sin(x(1,:)+x(2,:)))*ones(2);


[X,Y] = meshgrid(-5:0.1:5);
Z = sin(X+Y);
px = cos(X+Y);
py = cos(X+Y);
lvl = -1.2:0.3:1.2;

figure
surf(X,Y,Z)
hold on
contour3(X,Y,Z,lvl,'-k',LineWidth=2)
hold off
xlim([-2,2])
ylim([-2,2])
zlim([lvl(1),lvl(end)])


%% Gradient descent

maxit = 1000;
x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

alpha = 1;
% alpha = 0.5;
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

fprintf('\nConverge after %i iterations\n',iter)
fprintf('\nElapsed time is %.2e seconds\n',tgrad)
fprintf('\nThe solution is [%.4f %.4f ],  function value is %.4f\n',x_grad(:,end)',f(x_grad(:,end)))

figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,-px,-py)
plot(x_grad(1,:),x_grad(2,:),'-.r',LineWidth=3)
plot(x_grad(1,end),x_grad(2,end),'*',LineWidth=3)
title('gradient descent')

xlim([-1,4])
ylim([-1,4])


%% Newton's method/Newton Raphson 

x_newton(:,1) = x0;

alpha = 0.1;
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

fprintf('\nConverge after %i iterations\n',iter)
fprintf('\nElapsed time is %.2e seconds\n',tgrad)
fprintf('\nThe solution is [%.4f %.4f ],  function value is %.4f\n',x_newton(:,end)',f(x_newton(:,end)))


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

xlim([-1,4])
ylim([-1,4])
