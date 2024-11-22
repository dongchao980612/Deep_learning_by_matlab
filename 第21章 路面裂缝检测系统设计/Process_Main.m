function Result = Process_Main(I)
% ������
% ���������
% I��������ͼ��
% ���������
% Result�������ͼ��
 
 % �ҶȻ�
if ndims(I) == 3
    I1 = rgb2gray(I);
else
    I1 = I;
end

% ֱ��ͼ��ǿ
I2 = hist_con(I1,0);
% ��ֵ�˲�
I3 = med_process(I2,0);
% ͼ����ǿ
I4 = adjgamma(I3, 2);
% ����������ֵ
[bw, th] = IterProcess(I4); % th = 0.5438

bw = ~bw; % ��ɫ
% ��ֵͼ���˲�
bwn1 = bw_filter(bw, 15);
% �ѷ�ʶ��
bwn2 = Identify_Object(bwn1);

% ����ͶӰ
[projectr, projectc] = ImageProject(bwn2);
[r, c] = size(bwn2);
% �ѷ��ж�
bwn3 = Judge_Crack(bwn2, I4);
% �ѷ�ƴ��
bwn4 = Bridge_Crack(bwn3);

% �ѷ���״ʶ��
[flag, rect] = Judge_Direction(bwn4);
if flag == 1
    str = '�����ѷ�';
    wdmax = max(projectc);
    wdmin = min(projectc);
else
    str = '�����ѷ�';
    wdmax = max(projectr);
    wdmin = min(projectr);
end



% ����ͼ��
Result.Image = I1;
% ֱ��ͼ��ǿ
Result.hist = I2;
% ��ֵ�˲�
Result.Medfilt = I3;
% ͼ����ǿ
Result.Enance = I4;
% ��ֵͼ��
Result.Bw = bw;
% ��ֵͼ���˲�
Result.BwFilter = bwn1;
% �ѷ�ʶ��
Result.CrackRec = bwn2;
% �ѷ�ͶӰ
Result.Projectr = projectr;
Result.Projectc = projectc;
% �ѷ��ж�
Result.CrackJudge = bwn3;
% �ѷ�ƴ��
Result.CrackBridge = bwn4;
% �ѷ���״
Result.str = str;
% �ѷ���
Result.rect = rect;
% ���Ķ�ֵͼ��
Result.BwEnd = bwn4;
% �����Ϣ
Result.BwArea = bwarea(bwn4);
% ������Ϣ
Result.BwLength = max(rect(3:4));
% �����Ϣ
Result.BwWidthMax = wdmax;
% �����Ϣ
Result.BwWidthMin = wdmin;
% ��ֵ��Ϣ
Result.BwTh = th;
