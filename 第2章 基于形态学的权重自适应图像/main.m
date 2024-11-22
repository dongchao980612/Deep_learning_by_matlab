clc;clear; close all;

Img = imread('MonaLisa.png');

if ndims(Img) == 3
    I = rgb2gray(Img);
else
    I = Img;
end

I_with_noise = imnoise(I,'poisson');
s = GetStrelList();
e = ErodeList(I_with_noise, s);
f = GetRateList(I_with_noise, e);
Igo = GetRemoveResult(f, e);

figure;
subplot(1, 2, 1); imshow(I, []); title('原图像');
subplot(1, 2, 2); imshow(I_with_noise, []); title('噪声图像');


figure;
subplot(2, 2, 1); imshow(e.eroded_co12, []); title('串联1处理结果');
subplot(2, 2, 2); imshow(e.eroded_co22, []); title('串联2处理结果');
subplot(2, 2, 3); imshow(e.eroded_co32, []); title('串联3处理结果');
subplot(2, 2, 4); imshow(e.eroded_co42, []); title('串联4处理结果');

figure;
subplot(1, 2, 1); imshow(I, []); title('噪声图像');
subplot(1, 2, 2); imshow(Igo, []); title('并联去噪图像');

psnr1 = PSNR(I, e.eroded_co12);
psnr2 = PSNR(I, e.eroded_co22);
psnr3 = PSNR(I, e.eroded_co32);
psnr4 = PSNR(I, e.eroded_co42);
psnr5 = PSNR(I, Igo);
psnr_list = [psnr1 psnr2 psnr3 psnr4 psnr5];
disp(psnr_list)

figure; 
plot(1:5, psnr_list, 'r+-');
axis([0 6 24 30]);
set(gca, 'XTick', 0:6, 'XTickLabel', {'', '串联1', '串联2', '串联3', ...
    '串联4', '并联', ''});
% grid on;
title('PSNR曲线比较');