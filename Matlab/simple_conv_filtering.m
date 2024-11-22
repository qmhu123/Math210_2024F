clear;close all;clc

clear;close all;clc
fname = '5.3.02';
pic = imread("peppers.png");
pic = im2gray(pic);
I = double(pic);
figure;
imshow(pic);


filter = -ones(3);
filter(2,2)= 9;

% filter = [0 -1 0;
%         -1 5 -1;
%         0 -1 0];

% l = [1 1 1];
% filter = [l;zeros(size(l));-l]';


pic_filter = conv2(I,filter,'same');

figure;
imshow(pic_filter);