function res = QrDen(qr_im)
% QrDen 读取并解码二维码图像
%
% 参数:
%   qr_im (matrix or string): 二维码图像矩阵或文件名
%
% 返回值:
%   res (string): 解码后的文本

% 设置默认参数
if nargin < 1
    load('mtx.mat');
    qr_im = mtx;
end

% 获取 zxing_encrypt.jar 的路径
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');
javaaddpath(zxingpath);

% 获取 zxing_decrypt.jar 的路径
zxingpath = fullfile(pwd, 'zxing_decrypt.jar');
javaaddpath(zxingpath);

% 将图像转换为 Java 图像对象
qr_im = im2java(qr_im);

% 获取图像的宽度和高度
width = qr_im.getWidth();
height = qr_im.getHeight();

% 创建 BufferedImageLuminanceSource 对象
source = com.google.zxing.client.j2se.BufferedImageLuminanceSource(qr_im.getBufferedImage());

% 创建 HybridBinarizer 对象
binarizer = com.google.zxing.common.HybridBinarizer(source);

% 创建 BinaryBitmap 对象
bitmap = com.google.zxing.BinaryBitmap(binarizer);

% 创建 MultiFormatReader 对象
reader = com.google.zxing.MultiFormatReader();

% 解码二维码
res = char(reader.decode(bitmap).getText());
end