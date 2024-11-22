clear;close all; clc

[X,Y] = meshgrid(-5:0.1:5);

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


figure
contour3(X,Y,Z,LineWidth=2)

zlim([lvl(1),lvl(end)])
figure
contour(X,Y,Z,lvl,ShowText="on")
