function c = GetFaceVector(img)
% GetFaceVector 将图像转换为 PCA 特征向量
%
% 参数:
%   img (matrix): 输入的图像矩阵
%
% 返回值:
%   c (vector): PCA 特征向量

% 加载模型信息
load(fullfile(pwd, './face_lib/model.mat'));

% 获取图像的行数和列数
[row, col] = size(img);

% 将图像展平为一维向量
b = img(1:row*col);

% 将向量转换为双精度类型
b = double(b);

% 去均值
b = b - samplemean;

% 计算 PCA 特征向量
c = b * base;

% 确保结果为实数
c = real(c);
end