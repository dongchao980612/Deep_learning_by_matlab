function c = GetFaceVector(img)
% GetFaceVector ��ͼ��ת��Ϊ PCA ��������
%
% ����:
%   img (matrix): �����ͼ�����
%
% ����ֵ:
%   c (vector): PCA ��������

% ����ģ����Ϣ
load(fullfile(pwd, './face_lib/model.mat'));

% ��ȡͼ�������������
[row, col] = size(img);

% ��ͼ��չƽΪһά����
b = img(1:row*col);

% ������ת��Ϊ˫��������
b = double(b);

% ȥ��ֵ
b = b - samplemean;

% ���� PCA ��������
c = b * base;

% ȷ�����Ϊʵ��
c = real(c);
end