function f = mfcc(x,fs)
% 提取mfcc 特征
% 输入参数：
% x——信号
% fs——采样率
% 输出参数：
% f——特征
% 归一化mel 滤波器组系数

bank=melbankm(12,256,fs,0,0.5,'m');
bank=full(bank);
bank=bank/max(bank(:));

% DCT 系数,12*24
for k=1:12
    n=0:11;
    dctcoef(k,:)=cos((2*n+1)*k*pi/(2*12));
end

% 归一化倒谱提升窗口
w = 1 + 6 * sin(pi * [1:12] ./ 12);
w = w/max(w);
% 预加重滤波器
xx=double(x);
xx=filter([1 -0.9375],1,xx);
% 语音信号分帧
xx=enframe(xx,256,80);

% 计算每帧的MFCC 参数
for i=1:size(xx,1)
    y = xx(i,:);
    s = y' .* hamming(256);
    t = abs(fft(s));
    t = t.^2;
    c1=dctcoef * log(bank * t(1:129));
    c2 = c1.*w';
    m(i,:)=c2';
end

%差分系数
dtm = zeros(size(m));
for i=3:size(m,1)-2
    dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
end
dtm = dtm / 3;

%合并mfcc 参数和一阶差分mfcc 参数
f = [m dtm];

%去除首尾两帧，因为这两帧的一阶差分参数为0
f = f(3:size(m,1)-2,:);
