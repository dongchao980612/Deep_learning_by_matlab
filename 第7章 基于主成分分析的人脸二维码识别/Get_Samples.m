function allsamples = Get_Samples(classNum, sampleNum)
% Get_Samples 获取指定类别的样本图像并将其展平为向量
%
% 参数:
%   classNum (int): 类别数量，默认为40
%   sampleNum (int): 每个类别的样本数量，默认为10
%
% 返回值:
%   allsamples (matrix): 所有样本图像展平后的矩阵，每一行对应一个样本

% 设置默认参数
if nargin < 2
    sampleNum = 10;
end
if nargin < 1
    classNum = 40;
end

% 初始化 allsamples 矩阵
allsamples = [];

% 遍历每个类别和每个样本
for i = 1:classNum
    for j = 1:sampleNum
        % 读取图像文件
        filename = sprintf('./face_db/ORL%03d.BMP', (i-1)*sampleNum + j);
        a = imread(filename);
        
        % 获取图像的行数和列数
        [row, col] = size(a);
        
        % 将图像展平为一维向量
        b = a(1:row*col);
        
        % 将向量转换为双精度类型
        b = double(b);
        
        % 将矩阵 b 追加到矩阵 allsamples 的末尾
        allsamples = [allsamples; b];
    end
end