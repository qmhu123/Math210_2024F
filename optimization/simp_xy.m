clear;close all; clc

[X,Y] = meshgrid(-5:0.25:5);

%% z=xy

Z = X.*Y;

py = X;
px = Y;

lvl = -2:0.5:2;
lvl = lvl*2;

%% surface and contour 3d
figure
surf(X,Y,Z)
hold on
contour3(X,Y,Z,lvl,'-k',LineWidth=2,ShowText='on')
hold off
xlim([-2,2])
ylim([-2,2])
zlim([lvl(1),lvl(end)])

pxynorm = (px.^2+py.^2).^0.5;
px = px./pxynorm;
py= py./pxynorm;


 x0 = [3;1]; % inital point
% x0 = [-3;3]; % inital point
% x0 = 5*rand(2,1); 

f = @(x) x(1,:)*x(2,:);
pf = @(x) [x(2,:);x(1,:)];
hf = [0,1;1,0];


%% Gradient descent

maxit = 1000;
x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

alpha = 0.1;
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

fprintf('\n=========Gradient descent===============\n')
fprintf('\nConverge after %i iterations\n',iter)
fprintf('\nElapsed time is %.2e seconds\n',tgrad)
fprintf('\nThe solution is [%.4e %.4e ], function value is %.4e \n',x_grad(:,end)',f(x_grad(:,end)))


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


%% Newton's method/Newton Raphson 

x_newton(:,1) = x0;

tol = 1e-6;
tstart = tic;
for iter = 2:maxit
    x_newton(:,iter) = x_newton(:,iter-1) - hf\pf(x_newton(:,iter-1));
    if norm(x_newton(:,iter) - x_newton(:,iter-1))<tol
        x_newton(:,iter+1:end) = [];
        break;
    end
end
tgrad = toc(tstart);


fprintf("\n=========Newton's method===============\n")
fprintf('\nConverge after %i iterations\n',iter)
fprintf('\nElapsed time is %.2e seconds\n',tgrad)
fprintf('\nThe solution is [%.4f %.4f ], function value is %.4f \n',x_newton(:,end)',f(x_newton(:,end)))


figure
contour(X,Y,Z,lvl,ShowText="on")

hold on
quiver(X,Y,-px,-py)
plot(x_newton(1,:),x_newton(2,:),'-r',LineWidth=3)
plot(x_newton(1,end),x_newton(2,end),'*',LineWidth=3)

xlim([-2,2])
ylim([-2,2])



%% accel
maxit = 1000;
x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

alpha = 0.1;
% alpha = 0.5;
tol = 1e-6;
tstart = tic;
m = 0;
for iter = 2:maxit
    p = pf(x_grad(:,iter-1))+0.9*m;
    x_grad(:,iter) = x_grad(:,iter-1) - alpha*p;
    if norm(x_grad(:,iter) - x_grad(:,iter-1))<tol
        x_grad(:,iter+1:end) = [];
        break;
    end
    m = x_grad(:,iter) -x_grad(:,iter-1);
end
tgrad = toc(tstart);

fprintf('\n=========Gradient descent with momentum===============\n')
fprintf('\nConverge after %i iterations\n',iter)
fprintf('\nElapsed time is %.2e seconds\n',tgrad)
fprintf('\nThe solution is [%.4e %.4e ], function value is %.4e \n',x_grad(:,end)',f(x_grad(:,end)))


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
