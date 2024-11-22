function Construct_PCA_DataBase(classNum, sampleNum)
% Construct_PCA_DataBase ���� PCA ���ݿ�
%
% ����:
%   classNum (int): ���������Ĭ��Ϊ40
%   sampleNum (int): ÿ����������������Ĭ��Ϊ10
%
% ����ֵ:
%   �޷���ֵ�������� ./face_lib/model.mat �ļ��б��� base �� samplemean ����

% ȷ�� face_lib �ļ��д���
if ~exist(fullfile(pwd, './face_lib'), 'dir')
    mkdir(fullfile(pwd, './face_lib'));
end

% ����Ѿ�����ģ����Ϣ
if exist(fullfile(pwd, './face_lib/model.mat'), 'file')
    return;
end

% ����Ĭ�ϲ���
if nargin < 2
    sampleNum = 10;
end
if nargin < 1
    classNum = 40;
end

% �����ȴ���
hw = waitbar(0, '����PCA���ݿ���ȣ�', 'Name', 'PCA����ʶ��');

% ���µȴ���
rt = 0.1;
waitbar(rt, hw, sprintf('����PCA���ݿ���ȣ�%i%%', round(rt * 100)));

% ��ȡ����
allsamples = Get_Samples(classNum, sampleNum); % classNum * sampleNum ��

% ���µȴ���
rt = 0.3;
waitbar(rt, hw, sprintf('����PCA���ݿ���ȣ�%i%%', round(rt * 100)));

% �����ֵ����һ��
samplemean = mean(allsamples); % 1 * 10304
xmean = Get_StandSample(allsamples, samplemean); % classNum * sampleNum * 10304

% ���µȴ���
rt = 0.5;
waitbar(rt, hw, sprintf('����PCA���ݿ���ȣ�%i%%', round(rt * 100)));

% ����Э�������
sigma = xmean * xmean'; % 4 * 4

% ��������ֵ����������
[v, d] = eig(sigma);
d1 = diag(d); % 4 * 1

% ���µȴ���
rt = 0.7;
waitbar(rt, hw, sprintf('����PCA���ݿ���ȣ�%i%%', round(rt * 100)));

% ������ֵ������������������
dsort = flipud(d1);
vsort = fliplr(v);

% ���������
p = classNum * sampleNum;
base = xmean' * vsort(:, 1:p) * diag(dsort(1:p).^(-1/2));

% ���µȴ���
rt = 0.9;
waitbar(rt, hw, sprintf('����PCA���ݿ���ȣ�%i%%', round(rt * 100)));

% ����ģ����Ϣ
save(fullfile(pwd, './face_lib/model.mat'), 'base', 'samplemean');

% ���µȴ���
rt = 1;
waitbar(rt, hw, sprintf('����PCA���ݿ���ȣ�%i%%', round(rt * 100)));

% ɾ���ȴ���
delete(hw);

% ��ʾ�����ʾ
msgbox('����PCA���ݿ���ɣ�', '��ʾ��Ϣ', 'Modal');