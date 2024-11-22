clear;close all; clc

[X,Y] = meshgrid(-5:0.1:5);

%% simple parabolic surface

Z = sin(X+Y);
px = cos(X+Y);
py = cos(X+Y);
lvl = -1.2:0.2:1.2;


figure
surf(X,Y,Z)
hold on
contour3(X,Y,Z,lvl,'-k',LineWidth=2)
hold off
xlim([-2,2])
ylim([-2,2])
zlim([lvl(1),lvl(end)])


figure
contour3(X,Y,Z,'-k',LineWidth=2,ShowText='on')
figure
contour(X,Y,Z,lvl,ShowText="on")

figure
contour(X,Y,Z,lvl,ShowText="on")

px = px./abs(px+eps);
py= py./abs(py+eps);
hold on
quiver(X,Y,px,py)

xlim([-2,2])
ylim([-2,2])