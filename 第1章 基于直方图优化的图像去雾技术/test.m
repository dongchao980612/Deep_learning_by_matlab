clc; clear; close all;


I = imread('MonaLisa.png');

% ȫ��ֱ��ͼ����
res_RemoveFogByGlobalHisteq = RemoveFogByGlobalHisteq(I,1);

% �ֲ�ֱ��ͼ����
res_RemoveFogByLocalHisteq= RemoveFogByLocalHisteq(I,0);

% Retinex��ǿ����
res_RemoveFogByRetinex= RemoveFogByRetinex(I,0);

figure; 
subplot(2, 2, 1); imshow(I); title('ԭͼ');
subplot(2, 2, 2); imshow(res_RemoveFogByGlobalHisteq); title('ȫ��ֱ��ͼ����');
subplot(2, 2, 3); imshow(res_RemoveFogByLocalHisteq); title('�ֲ�ֱ��ͼ����')
subplot(2, 2, 4); imshow(res_RemoveFogByRetinex); title('Retinex��ǿ����')