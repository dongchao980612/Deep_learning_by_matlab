clc;clear;close all;

% warning off all;
%% 载入待检测图像
Img = imread(fullfile(pwd, 'face/01.BMP'));
sz = size(Img);
figure; imshow(Img, []);
title('人脸图像');

%% 构建 PCA 数据库
Construct_PCA_DataBase();

%% 获取降维特征
f = GetFaceVector(Img);
f = f(1:300);

%% 生成二维码
Im = QrGen(f);
figure; imshow(Im, []);
title('人脸二维码');

%% 写到二维码文件中
filenameqr = fullfile(pwd, 'qr.tif');
imwrite(Im, filenameqr);

%% 二维码识别
m = imread(filenameqr);
c = QrDen(m);

%% 识别
Ims = FaceRec(c, sz);
figure; imshow(Ims, []);
title('二维码识别人脸');