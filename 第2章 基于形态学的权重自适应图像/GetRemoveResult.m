function Igo = GetRemoveResult(f, e)
% 并联去噪
% 输入参数：
% f——权值向量
% e——串联结果
% 输出参数：
% Igo——处理结果
Igo = ... 
f.df1/f.df*double(e.eroded_co12)+f.df2/f.df*double(e.eroded_co22)+...
 f.df3/f.df*double(e.eroded_co32)+f.df4/f.df*double(e.eroded_co42);
Igo = mat2gray(Igo);