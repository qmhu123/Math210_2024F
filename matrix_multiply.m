clc;clear;close all;

%% rotating
theta = 0:pi/10:pi/2;
Atheta = @(t) [ cos(t),sin(t);
                -sin(t),cos(t)];
l = length(theta);
unitx=sin(0:0.05*pi:2*pi);
unity=cos(0:0.05*pi:2*pi);
v_init = rand(2,1);
v_init = v_init/norm(v_init);
disp(v_init)
xline(0);
yline(0);

xs = [0,v_init(1)];
ys = [0,v_init(2)];
figure
plot(xs,ys,'-r','LineWidth',4);
xlim([-1.2,1.2])
ylim([-1.2,1.2])
xline(0);
yline(0);
xline(1);
yline(1);
hold on 
plot(unitx,unity,'-g')
for idx = 1:l
    A = Atheta(theta(idx));
    v = A*v_init;
    xs = [0,v(1)];
    ys = [0,v(2)];
    plot(xs,ys,'-k');
end
% 
% vw = VideoWriter(['rotatingmatrix.avi']);
% vw.FrameRate=15;
% 
% 
% open(vw);
% for f = 1:width(videog)
%     frame = real(L(:,:,f));
%     writeVideo(vw,mat2gray(frame));
%     S_sub(:,:,f) = mat2gray(frame);
% end
% close(vw);% 
% %% scaling
% Atheta = @(t) [ 1,0;
%                 0,t];
% %v_init = rand(2,1);
% 
% 
% %v_init =v_init/norm(v_init);
% v_init = [2,1]';
% t = 2;
% A = Atheta(t);
% v = A*v_init;
% 
% xs = [0,v_init(1)];
% ys = [0,v_init(2)];
% 
% figure
% 
% plot(xs,ys,'-r','linewidth',2);
% xlim([-t,t])
% ylim([-t,t])
% xline(v_init(1));
% yline(v_init(2));
% 
% xline(0);
% yline(0);
% 
% hold on 
% 
% 
% xs = [0,v(1)];
% ys = [0,v(2)];
% 
% plot(xs,ys,'-r','linewidth',2);
% 
% 
% xline(v(1));