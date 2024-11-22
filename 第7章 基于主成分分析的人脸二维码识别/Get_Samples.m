function allsamples = Get_Samples(classNum, sampleNum)
% Get_Samples ��ȡָ����������ͼ�񲢽���չƽΪ����
%
% ����:
%   classNum (int): ���������Ĭ��Ϊ40
%   sampleNum (int): ÿ����������������Ĭ��Ϊ10
%
% ����ֵ:
%   allsamples (matrix): ��������ͼ��չƽ��ľ���ÿһ�ж�Ӧһ������

% ����Ĭ�ϲ���
if nargin < 2
    sampleNum = 10;
end
if nargin < 1
    classNum = 40;
end

% ��ʼ�� allsamples ����
allsamples = [];

% ����ÿ������ÿ������
for i = 1:classNum
    for j = 1:sampleNum
        % ��ȡͼ���ļ�
        filename = sprintf('./face_db/ORL%03d.BMP', (i-1)*sampleNum + j);
        a = imread(filename);
        
        % ��ȡͼ�������������
        [row, col] = size(a);
        
        % ��ͼ��չƽΪһά����
        b = a(1:row*col);
        
        % ������ת��Ϊ˫��������
        b = double(b);
        
        % ������ b ׷�ӵ����� allsamples ��ĩβ
        allsamples = [allsamples; b];
    end
end