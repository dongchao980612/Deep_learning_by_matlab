function fileList = getAllFiles(foldername)
% ������ȡ�������ļ�
% ���������
% foldername�����ļ���
% ���������
% fileList�����ļ��б�

% ��ȡ�ļ���Ϣ
folderData = dir(foldername);
% ��ȡ������Ϣ
folderIndex = [folderData.isdir];
% ��ȡ�ļ��б�
fileList = {folderData(~folderIndex).name}';

if ~isempty(fileList)
    % ����ǿգ��������ļ�·�����б���
    fileList = cellfun(@(x) fullfile(foldername,x),...
        fileList,'UniformOutput',false);
end

% ��ȡ���ļ��б�
subfolders = {folderData(folderIndex).name};

% ������Ч·��
errIndex = ~ismember(subfolders,{'.','..'});

for iDir = find(errIndex)
    % ��ȡ�ļ�����Ϣ
    nextDir = fullfile(foldername,subfolders{iDir});
    % ��ȡ�ļ��б�
    fileList = [fileList; getAllFiles(nextDir)];
end