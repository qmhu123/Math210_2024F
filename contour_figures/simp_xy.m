clear;close all; clc

[X,Y] = meshgrid(-5:0.1:5);

%% z=xy

Z = X.*Y;

py = X;
px = Y;

lvl = -2:0.2:2;
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

%% contour 3d
figure
contour3(X,Y,Z,LineWidth=2)


%% contour 
figure
contour(X,Y,Z,lvl,ShowText="on")


%% contour and grad
figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,px,py)


xlim([-2,2])
ylim([-2,2])