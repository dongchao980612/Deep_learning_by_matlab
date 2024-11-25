clc; clear; close all;


I = imread('MonaLisa.png');

% 全局直方图处理
res_RemoveFogByGlobalHisteq = RemoveFogByGlobalHisteq(I,1);

% 局部直方图处理
res_RemoveFogByLocalHisteq= RemoveFogByLocalHisteq(I,0);

% Retinex增强处理
res_RemoveFogByRetinex= RemoveFogByRetinex(I,0);

figure; 
subplot(2, 2, 1); imshow(I); title('原图');
subplot(2, 2, 2); imshow(res_RemoveFogByGlobalHisteq); title('全局直方图处理');
subplot(2, 2, 3); imshow(res_RemoveFogByLocalHisteq); title('局部直方图处理')
subplot(2, 2, 4); imshow(res_RemoveFogByRetinex); title('Retinex增强处理')