function MC = GetFeather(file, flag)
% 获取音频文件的特征
% 输入参数：
% file——文件路径
% flag——显示标记
% 输出参数：
% MC——特征

if nargin < 2
    flag = 0;
end
if nargin < 1
    file = '.\wav\Database\关闭\关闭_bsm.wav';
end
[signal, fs] = audioread(file);%      10705           1

framelength = 1024;
% 帧数

framenumber = fix(length(signal)/framelength);

for L = 1:framenumber
    for m = 1:framelength
        framedata(m) = signal((L-1)*framelength+m);
    end
    % 计算每帧的能量
    E(L) = sum(framedata.^2);
end

if flag
    figure; plot(E);title(file);
end
% 求能量平均值
meanE = mean(E);
% 有效音的起始帧标记
startflag=0;
% 有效音的帧数
startnum=0;
% 有效音的起始帧
startframe=0;
% 有效音的结束帧
endframe = 0;
S = [];
% 判断浊音的起始帧位置
for L = 1 : framenumber
    if E(L) > meanE
   
        % 如果该帧能量大于平均能量，则认为该帧是起始帧
        startnum = startnum+1;
        if startnum == 2
            % 如果连续有3 帧是浊音帧，则认为是真正的浊音段
            startframe = L-2;
            startflag = 1;
        end
    end
    if E(L) < meanE
        %如果该帧能量小于平均能量，则认为该帧是结束帧
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