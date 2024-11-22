function S = GetDatabase(dirName)
% 构建数据库
% 输入参数：
% dirName——路径
% 输出参数：
% S——数据库

% 检查 S.mat 是否存在
if exist('S.mat', 'file') == 2
    % 如果存在，则加载并直接返回
    load('S.mat', 'S');
    return;
end

if nargin < 1
    % 数据库路径
    dirName = './wav/Database';
end
h = waitbar(0, '', 'Name', '获取音频信号特征...');

% 获取wav 文件列表
fileList = getAllFiles(dirName);
steps = length(fileList);

for i = 1 : steps
    file = fileList{i};
    [~, name, ~]= fileparts(file);
    ind = strfind(name, '语音信号');
    if ~isempty(ind)
        name = name(1:ind-1);
        name = strtrim(name);
    end
    MC = GetFeather(file);
    S(i).name = name;
    S(i).MC = MC;
    waitbar(i/steps, h, sprintf('已处理：%d%%', round(i/steps*100)));
end
close(h);
save S.mat S