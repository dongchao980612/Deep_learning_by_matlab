function S = GetDatabase(dirName)
% �������ݿ�
% ���������
% dirName����·��
% ���������
% S�������ݿ�

% ��� S.mat �Ƿ����
if exist('S.mat', 'file') == 2
    % ������ڣ�����ز�ֱ�ӷ���
    load('S.mat', 'S');
    return;
end

if nargin < 1
    % ���ݿ�·��
    dirName = './wav/Database';
end
h = waitbar(0, '', 'Name', '��ȡ��Ƶ�ź�����...');

% ��ȡwav �ļ��б�
fileList = getAllFiles(dirName);
steps = length(fileList);

for i = 1 : steps
    file = fileList{i};
    [~, name, ~]= fileparts(file);
    ind = strfind(name, '�����ź�');
    if ~isempty(ind)
        name = name(1:ind-1);
        name = strtrim(name);
    end
    MC = GetFeather(file);
    S(i).name = name;
    S(i).MC = MC;
    waitbar(i/steps, h, sprintf('�Ѵ���%d%%', round(i/steps*100)));
end
close(h);
save S.mat S