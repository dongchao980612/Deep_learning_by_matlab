function Construct_PCA_DataBase(classNum, sampleNum)
% Construct_PCA_DataBase 构建 PCA 数据库
%
% 参数:
%   classNum (int): 类别数量，默认为40
%   sampleNum (int): 每个类别的样本数量，默认为10
%
% 返回值:
%   无返回值，但会在 ./face_lib/model.mat 文件中保存 base 和 samplemean 变量

% 确保 face_lib 文件夹存在
if ~exist(fullfile(pwd, './face_lib'), 'dir')
    mkdir(fullfile(pwd, './face_lib'));
end

% 如果已经存在模型信息
if exist(fullfile(pwd, './face_lib/model.mat'), 'file')
    return;
end

% 设置默认参数
if nargin < 2
    sampleNum = 10;
end
if nargin < 1
    classNum = 40;
end

% 创建等待条
hw = waitbar(0, '构建PCA数据库进度：', 'Name', 'PCA人脸识别');

% 更新等待条
rt = 0.1;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt * 100)));

% 获取样本
allsamples = Get_Samples(classNum, sampleNum); % classNum * sampleNum 行

% 更新等待条
rt = 0.3;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt * 100)));

% 计算均值并归一化
samplemean = mean(allsamples); % 1 * 10304
xmean = Get_StandSample(allsamples, samplemean); % classNum * sampleNum * 10304

% 更新等待条
rt = 0.5;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt * 100)));

% 计算协方差矩阵
sigma = xmean * xmean'; % 4 * 4

% 计算特征值和特征向量
[v, d] = eig(sigma);
d1 = diag(d); % 4 * 1

% 更新等待条
rt = 0.7;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt * 100)));

% 对特征值和特征向量进行排序
dsort = flipud(d1);
vsort = fliplr(v);

% 计算基向量
p = classNum * sampleNum;
base = xmean' * vsort(:, 1:p) * diag(dsort(1:p).^(-1/2));

% 更新等待条
rt = 0.9;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt * 100)));

% 保存模型信息
save(fullfile(pwd, './face_lib/model.mat'), 'base', 'samplemean');

% 更新等待条
rt = 1;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt * 100)));

% 删除等待条
delete(hw);

% 显示完成提示
msgbox('构建PCA数据库完成！', '提示信息', 'Modal');