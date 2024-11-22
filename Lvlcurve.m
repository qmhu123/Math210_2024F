clear;clc;close all;
[x,y] = meshgrid(-4:0.1:4);
z = x.^2+y.^2;
figure;
surf(x,y,z)
t = 0:0.05*pi:2*pi;
xt = sin(t);yt=cos(t);
l = ones(size(t));
hold on
for r = 2.^(-0.5:0.5:2)    
    plot3(r*xt',r*yt',r*l',LineWidth=2,Color=[1,1,1])
end
hold off
xlim([-4,4])
ylim([-4,4])
zlim([-5,30])


% [dx,dy] = gradient(z,0.1,0.1);
dx = 2*x;dy = 2*y;
figure
hold on 
contour(x,y,z,(2.^(-1:0.5:3)))
quiver(x,y,dx,dy)
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear;clc;close all;
% [x,y] = meshgrid(-4:0.1:4);
% z = x.^2+y.^2;
% figure;
% surf(x,y,z)
% t = 0:0.05*pi:2*pi;
% xt = sin(t);yt=cos(t);
% l = ones(size(t));
% hold on
% for r = 2.^(-0.5:0.5:2)    
%     plot3(r*xt',r*yt',r*l',LineWidth=2,Color=[1,1,1])
% end
% hold off
% xlim([-4,4])
% ylim([-4,4])
% zlim([-5,30])
% 
% 
% % [dx,dy] = gradient(z,0.1,0.1);
% dx = 2*x;dy = 2*y;
% figure
% hold on 
% contour(x,y,z,(2.^(-1:0.5:3)))
% quiver(x,y,dx,dy)
% hold off