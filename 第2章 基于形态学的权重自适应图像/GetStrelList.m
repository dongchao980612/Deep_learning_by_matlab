function s = GetStrelList()
% ��ȡ����
% ���������
% s�������ӽṹ��
% ���ɴ�������
s.co11 = strel('line',5,-45);
s.co12 = strel('line',7,-45);
% ���ɴ�������
s.co21 = strel('line',5,45);
s.co22 = strel('line',7,45);
% ���ɴ�������
s.co31 = strel('line',3,90);
s.co32 = strel('line',5,90);
% ���ɴ�������
s.co41 = strel('line',3,0);
s.co42 = strel('line',5,0);