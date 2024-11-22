clear;clc;close all

fid = fopen('QR_iter_example.txt','w');

A = [2 3 -2;3 1 0; -3 -3 3];

fprintf(fid,' A = \n');
fprintf(fid,' %.4f %.4f %.4f\n',A');

[v,d] = eig(A);

fprintf(fid,'\n\n==========Eigen values================\n\n');

fprintf(fid,'\n v = \t\t\t\t\t d=\n');
fprintf(fid,'%.4f %.4f %.4f \t\t %.4f %.4f %.4f\n',[v';d']);

fprintf(fid,'\n\n==========QR Iteration================\n\n');
tic
AA = A;
for iter = 1:10
    [Q,R] = qr(AA);
    fprintf(fid,'\n Q = \t\t\t\t\t R=\n');
    fprintf(fid,'%.4f %.4f %.4f \t\t %.4f %.4f %.4f\n',[Q';R']);
    AA = R*Q;
    fprintf(fid,'\n iter = %d \n',iter);
    fprintf(fid,'A = \n');
    fprintf(fid,'%.4f %.4f %.4f\n',AA');
end

toc
fprintf(fid,'\n\n==========Symmetric example================\n\n');
tic
AA = A'*A;
fprintf(fid,' A = \n');
fprintf(fid,' %.4f %.4f %.4f\n',AA');

[v,d] = eig(AA);

fprintf(fid,'\n\n==========Eigen values================\n\n');

fprintf(fid,'\n v = \t\t\t\t\t d=\n');
fprintf(fid,'%.4f %.4f %.4f \t\t %.4f %.4f %.4f\n',[v';d']);

fprintf(fid,'\n\n==========QR Iteration================\n\n');

for iter = 1:5
    [Q,R] = qr(AA);
    fprintf(fid,'\n Q = \t\t\t\t\t R=\n');
    fprintf(fid,'%.4f %.4f %.4f \t\t %.4f %.4f %.4f\n',[Q';R']);
    AA = R*Q;
    fprintf(fid,'\n iter = %d \n',iter);
    fprintf(fid,'\n A = \n');
    fprintf(fid,'%.4f %.4f %.4f\n',AA');
end
toc
fclose(fid);

