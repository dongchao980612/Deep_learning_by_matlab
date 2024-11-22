function Result = Process_Main(I)
% 主函数
% 输入参数：
% I——输入图像
% 输出参数：
% Result——结果图像
 
 % 灰度化
if ndims(I) == 3
    I1 = rgb2gray(I);
else
    I1 = I;
end

% 直方图增强
I2 = hist_con(I1,0);
% 中值滤波
I3 = med_process(I2,0);
% 图像增强
I4 = adjgamma(I3, 2);
% 迭代法求阈值
[bw, th] = IterProcess(I4); % th = 0.5438

bw = ~bw; % 反色
% 二值图像滤波
bwn1 = bw_filter(bw, 15);
% 裂缝识别
bwn2 = Identify_Object(bwn1);

% 曲线投影
[projectr, projectc] = ImageProject(bwn2);
[r, c] = size(bwn2);
% 裂缝判断
bwn3 = Judge_Crack(bwn2, I4);
% 裂缝拼接
bwn4 = Bridge_Crack(bwn3);

% 裂缝形状识别
[flag, rect] = Judge_Direction(bwn4);
if flag == 1
    str = '横向裂缝';
    wdmax = max(projectc);
    wdmin = min(projectc);
else
    str = '纵向裂缝';
    wdmax = max(projectr);
    wdmin = min(projectr);
end



% 输入图像
Result.Image = I1;
% 直方图增强
Result.hist = I2;
% 中值滤波
Result.Medfilt = I3;
% 图像增强
Result.Enance = I4;
% 二值图像
Result.Bw = bw;
% 二值图像滤波
Result.BwFilter = bwn1;
% 裂缝识别
Result.CrackRec = bwn2;
% 裂缝投影
Result.Projectr = projectr;
Result.Projectc = projectc;
% 裂缝判断
Result.CrackJudge = bwn3;
% 裂缝拼接
Result.CrackBridge = bwn4;
% 裂缝形状
Result.str = str;
% 裂缝标记
Result.rect = rect;
% 最后的二值图像
Result.BwEnd = bwn4;
% 面积信息
Result.BwArea = bwarea(bwn4);
% 长度信息
Result.BwLength = max(rect(3:4));
% 宽度信息
Result.BwWidthMax = wdmax;
% 宽度信息
Result.BwWidthMin = wdmin;
% 阈值信息
Result.BwTh = th;
