clear;close all;clc

clear;close all;clc
fname = '5.3.02';
pic = imread([fname,'.tiff']);
pic = im2gray(pic);
I = double(pic);
figure;
% subplot(2,2,1);
imshow(pic);

%% Eigen value decomp

[E,D] = eig(I);
for idx = 4:4
    ratio = 0.95;
    ratio = 1-ratio;
tic
    D = diag(D);
    dim = length(D);
    D(round(ratio*dim):end) = 0;
    D = diag(D);

    IE = (E*D/E);
toc
    IE = mat2gray(real(IE));
    
    figure
%     subplot(2,2,idx)
    imshow(IE);
end
% 
% set(gca,'LooseInset',get(gca,'TightInset'));
% saveas(gcf,[fname,'_eig.eps']) 


%% Singular value decomp

 [U,S,V] = svd(I);
% 
 S = diag(S);
 dim = length(S);
 l = ratio*dim;
 S(round(ratio*dim):end) = 0;
 S = diag(S);
 tic
 IS = (U*S*V');
 toc
 IS = mat2gray(real(IS));
 
 
 figure;
 imshow(IS);
 set(gca,'LooseInset',get(gca,'TightInset'));
 saveas(gcf,[fname,'_svd.eps']) 

