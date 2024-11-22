clc;clear;close all;
% Images here are sourced from:
% https://sipi.usc.edu/database/database.php
% which is the The USC-SIPI Image Database
% Except the Lenna image
%% lenna
% I=imread('lena_color.tiff');
% IM = im2gray(I);

%% High altitude aerial images
% I=imread('2.2.05.tiff');
% IM = im2gray(I);

%% Female (NTSC test image)
% I=imread('4.1.01.tiff');
% IM = im2gray(I);

%% Airport
I=imread('5.3.02.tiff');
IM = im2gray(I);

%% Female (NTSC test image)
% IM=imread('cameraman.tif');

%% compression using eig

imshow(IM);
imag = im2double(IM);

[E,D] = eig(imag);

fprintf('\nRank of this image is %i',rank(D))
ratio = 0.8;
fprintf('\nCompressed with %i%% Eigenvalues\n\n',ratio*100)

D = diag(D);
dim = length(D);
D(round(ratio*dim):end) = 0;
D = diag(D);

IE = (E*D/E);

IE = mat2gray(real(IE));


figure;
imshow(IE);



%% compression using svd
% imshow(IM);
% imag = im2double(IM);
% imshow(imag)
% [U,S,V] = svd(imag); 
% s = diag(S);
% norm(U*S*V'-imag,"fro")
% 
% s(33:end)=0;
% 
% imag2 = U*diag(s)*V';
% figure()
% imshow(imag2)
