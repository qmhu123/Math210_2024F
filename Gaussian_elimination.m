clc;clear;close all
A = [12 -1 0 -9
    -1 0 0 4
    3 -2 1 -19];
b = [0 0 0]';

A_aug = [A,b];

s = size(A_aug,1);
for j = 1:(s-1)
    for i = s:-1:j+1
        m = A_aug(i,j)/A_aug(j,j);
        A_aug(i,:) = A_aug(i,:) - m*A_aug(j,:);
        
    end
    disp(A_aug)
end 

for j = (s):-1:2
    for i = j-1:-1:1
        if A_aug(i,j)~=0
            m = A_aug(i,j)/A_aug(j,j);
            A_aug(i,:) = A_aug(i,:) - m*A_aug(j,:);
        end        
    end
    disp(A_aug)
end 

for j = 1:s
    A_aug(j,:) = A_aug(j,:)/A_aug(j,j);
    disp(A_aug)
end 
