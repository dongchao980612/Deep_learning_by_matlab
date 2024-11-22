function MC = GetFeather(file, flag)
% ��ȡ��Ƶ�ļ�������
% ���������
% file�����ļ�·��
% flag������ʾ���
% ���������
% MC��������

if nargin < 2
    flag = 0;
end
if nargin < 1
    file = '.\wav\Database\�ر�\�ر�_bsm.wav';
end
[signal, fs] = audioread(file);%      10705           1

framelength = 1024;
% ֡��

framenumber = fix(length(signal)/framelength);

for L = 1:framenumber
    for m = 1:framelength
        framedata(m) = signal((L-1)*framelength+m);
    end
    % ����ÿ֡������
    E(L) = sum(framedata.^2);
end

if flag
    figure; plot(E);title(file);
end
% ������ƽ��ֵ
meanE = mean(E);
% ��Ч������ʼ֡���
startflag=0;
% ��Ч����֡��
startnum=0;
% ��Ч������ʼ֡
startframe=0;
% ��Ч���Ľ���֡
endframe = 0;
S = [];
% �ж���������ʼ֡λ��
for L = 1 : framenumber
    if E(L) > meanE
   
        % �����֡��������ƽ������������Ϊ��֡����ʼ֡
        startnum = startnum+1;
        if startnum == 2
            % ���������3 ֡������֡������Ϊ��������������
            startframe = L-2;
            startflag = 1;
        end
    end
    if E(L) < meanE
        %�����֡����С��ƽ������������Ϊ��֡�ǽ���֡
        if startflag == 1
            endframe = L-1;
            S = [S; startframe endframe];
            startflag = 0;
            startnum = 0;
        end
    end
end

if size(S, 1) > 1
    ms = min(S(:, 1));
    es = max(S(:, 2));
else
    ms = S(1);
    es = S(2);
end

MC = [];
snum = 1;
for i = ms : es
    si = (i-1)*framelength;
    ei = i*framelength;
    fi = signal(si:ei);
    mc = mfcc(fi,fs);
    MC{snum} = mc;
    snum = snum + 1;
end