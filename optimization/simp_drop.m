clear;close all; clc

[X,Y] = meshgrid(-5:0.05:5);

%% simple parabolic surface

w = X.^2 + Y.^2;
Z = -(1+cos(12*sqrt(w)))./(0.5*w+2);
lvl = -3:0.3:3;
figure
surf(X,Y,Z)
hold on
contour3(X,Y,Z,lvl,'-k',LineWidth=2)
hold off
xlim([-2,2])
ylim([-2,2])
zlim([-1,1])

% function
f = @(x) -(1+cos(12*sqrt(x'*x)))./(0.5*x'*x+2);
% gradient
u = @(x) (x'*x);
pf = @(x) [12.*x(1,:)*(12*(u(x).^0.5))/((u(x).^0.5)*(0.5*u(x)+2)) - ...
    x(1,:).*(-cos(12*(u(x).^0.5))-1)/(0.5*u(x)+2).^2;
    12.*x(2,:)*(12*(u(x).^0.5))/((u(x).^0.5)*(0.5*u(x)+2)) - ...
    x(2,:).*(-cos(12*(u(x).^0.5))-1)/(0.5*u(x)+2).^2];


x0 = [3;3]; % inital point

maxit = 1000;
x_grad = zeros([2,maxit]);
x_grad(:,1) = x0;

alpha = 1e-6;
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
fprintf('The solution is [%.4e %.4e ], function value is %.4e \n',x_grad(:,end)',f(x_grad(:,end)))

figure
contour(X,Y,Z,lvl)

colormap winter

hold on
plot(x_grad(1,:),x_grad(2,:),'-r',LineWidth=3)
plot(x_grad(1,end),x_grad(2,end),'*',LineWidth=3)

xlim([x_grad(1,end) - 2,x_grad(1,end) + 2])
ylim([x_grad(2,end)- 2,x_grad(2,end) + 2])



%% Gradient descent  with momentum

x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

m = 0;
tstart = tic;
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
fprintf('The solution is [%.4e %.4e ], function value is %.4e \n',x_grad(:,end)',f(x_grad(:,end)))



figure
contour(X,Y,Z,lvl,ShowText="on")
plot(x_grad(1,:),x_grad(2,:),'-r',LineWidth=3)

xlim([-2,2])
ylim([-2,2])



