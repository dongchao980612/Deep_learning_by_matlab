function fileList = getAllFiles(foldername)
% 遍历获取整个子文件
% 输入参数：
% foldername——文件夹
% 输出参数：
% fileList——文件列表

% 获取文件信息
folderData = dir(foldername);
% 获取索引信息
folderIndex = [folderData.isdir];
% 获取文件列表
fileList = {folderData(~folderIndex).name}';

if ~isempty(fileList)
    % 如果非空，则整合文件路径到列表中
    fileList = cellfun(@(x) fullfile(foldername,x),...
        fileList,'UniformOutput',false);
end

% 获取子文件列表
subfolders = {folderData(folderIndex).name};

% 过滤无效路径
errIndex = ~ismember(subfolders,{'.','..'});

for iDir = find(errIndex)
    % 获取文件夹信息
    nextDir = fullfile(foldername,subfolders{iDir});
    % 获取文件列表
    fileList = [fileList; getAllFiles(nextDir)];
end