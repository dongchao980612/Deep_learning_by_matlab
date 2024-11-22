function f = GetRateList(Ig, e)
% 计算权重
% 输入参数：
% Ig——图像矩阵
% e——串联结果
% 输出参数：
% f——处理结果
f.df1 = sum(sum(abs(double(e.eroded_co12)-double(Ig))));
f.df2 = sum(sum(abs(double(e.eroded_co22)-double(Ig))));
f.df3 = sum(sum(abs(double(e.eroded_co32)-double(Ig))));
f.df4 = sum(sum(abs(double(e.eroded_co42)-double(Ig))));
f.df = sum([f.df1 f.df2 f.df3 f.df4]);