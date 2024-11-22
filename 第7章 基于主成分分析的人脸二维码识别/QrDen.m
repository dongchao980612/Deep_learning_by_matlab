function res = QrDen(qr_im)
% QrDen ��ȡ�������ά��ͼ��
%
% ����:
%   qr_im (matrix or string): ��ά��ͼ�������ļ���
%
% ����ֵ:
%   res (string): �������ı�

% ����Ĭ�ϲ���
if nargin < 1
    load('mtx.mat');
    qr_im = mtx;
end

% ��ȡ zxing_encrypt.jar ��·��
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');
javaaddpath(zxingpath);

% ��ȡ zxing_decrypt.jar ��·��
zxingpath = fullfile(pwd, 'zxing_decrypt.jar');
javaaddpath(zxingpath);

% ��ͼ��ת��Ϊ Java ͼ�����
qr_im = im2java(qr_im);

% ��ȡͼ��Ŀ�Ⱥ͸߶�
width = qr_im.getWidth();
height = qr_im.getHeight();

% ���� BufferedImageLuminanceSource ����
source = com.google.zxing.client.j2se.BufferedImageLuminanceSource(qr_im.getBufferedImage());

% ���� HybridBinarizer ����
binarizer = com.google.zxing.common.HybridBinarizer(source);

% ���� BinaryBitmap ����
bitmap = com.google.zxing.BinaryBitmap(binarizer);

% ���� MultiFormatReader ����
reader = com.google.zxing.MultiFormatReader();

% �����ά��
res = char(reader.decode(bitmap).getText());
end