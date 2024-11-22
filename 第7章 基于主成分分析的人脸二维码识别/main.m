clc;clear;close all;

% warning off all;
%% ��������ͼ��
Img = imread(fullfile(pwd, 'face/01.BMP'));
sz = size(Img);
figure; imshow(Img, []);
title('����ͼ��');

%% ���� PCA ���ݿ�
Construct_PCA_DataBase();

%% ��ȡ��ά����
f = GetFaceVector(Img);
f = f(1:300);

%% ���ɶ�ά��
Im = QrGen(f);
figure; imshow(Im, []);
title('������ά��');

%% д����ά���ļ���
filenameqr = fullfile(pwd, 'qr.tif');
imwrite(Im, filenameqr);

%% ��ά��ʶ��
m = imread(filenameqr);
c = QrDen(m);

%% ʶ��
Ims = FaceRec(c, sz);
figure; imshow(Ims, []);
title('��ά��ʶ������');