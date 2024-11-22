clear;close all; clc

[X,Y] = meshgrid(-2:0.1:2);


%% simple parabolic surface

Z = X.^2 + Y.^2;
px = 2*X;
py = 2*Y;
lvl = [0.1,0.5,1:3];

figure
surf(X,Y,Z)
hold on
contour3(X,Y,Z,lvl,'-k',LineWidth=2)
hold off
xlim([-2,2])
ylim([-2,2])
zlim([lvl(1),lvl(end)])

figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,px,py)

xlim([-2,2])
ylim([-2,2])


x0 = [3;3]; % inital point
% x0 = 5*rand(2,1); 

f = @(x) x'*x;
pf = @(x) 2*x;


%% Gradient descent

maxit = 1000;
x_grad = zeros([2,maxit]);
% x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

%alpha = 0.1;
alpha = 0.5;
tol = 1e-3;
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
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,-px,-py)
plot(x_grad(1,:),x_grad(2,:),'-r',LineWidth=3)
% plot()

xlim([-2,2])
ylim([-2,2])


%% Newton's method/Newton Raphson 

% 
% x_newton(:,1) = x0;
% 
% hx = 2*eye(2);
% invhx = 0.5*eye(2);
% 
% tstart = tic;
% for iter = 2:maxit
%     x_newton(:,iter) = x_newton(:,iter-1) - invhx*pf(x_newton(:,iter-1));
%     if norm(x_newton(:,iter) - x_newton(:,iter-1))<tol
%         x_newton(:,iter+1:end) = [];
%         break;
%     end
% end
% tgrad = toc(tstart);
% 
% fprintf("\n=========Newton's method===============\n")
% fprintf('Converge after %i iterations\n',iter)
% fprintf('Elapsed time is %.2e seconds\n',tgrad)
% fprintf('The solution is [%.4f %.4f ], function value is %.4f \n',x_newton(:,end)',f(x_newton(:,end)))
% 
% 
% 
% figure
% contour(X,Y,Z,lvl,ShowText="on")
% 
% px = px./abs(px+eps);
% py= py./abs(py+eps);
% hold on
% quiver(X,Y,-px,-py)
% plot(x_newton(1,:),x_newton(2,:),'-r',LineWidth=3)
% % plot()
% 
% xlim([-2,2])
% ylim([-2,2])
% 
% 
%% Gradient descent  with momentum

x_grad = zeros([2,maxit]);
x_newton = zeros([2,maxit]);
x_grad(:,1) = x0;

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
fprintf('The solution is [%.4e %.4e ], function value is %.4e \n',x_grad(:,end)',f(x_grad(:,end)))



figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,-px,-py)
plot(x_grad(1,:),x_grad(2,:),'-r',LineWidth=3)
% plot()

xlim([-2,2])
ylim([-2,2])
