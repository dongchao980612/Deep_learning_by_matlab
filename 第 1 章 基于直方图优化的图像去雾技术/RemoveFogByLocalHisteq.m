function In = RemoveFogByLocalHisteq(I, flag)
% 对 RGB 图像，分别对 R、G、B 进行均衡，再得到新 RGB 图像
% 输入参数：
% I——图像矩阵
% flag——显示标记
% 输出参数：
% In——结果图像

% 确定函数被调用时输入参数的数量
if nargin <2
    flag=1;
end

% 提取图像的R G B分量
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

% 分别对 R、G、B 三层分量进行局部直方图均衡化处理
g1 = GetLocalHisteq(R);
g2 = GetLocalHisteq(G);
g3 = GetLocalHisteq(B);

% 通过集成局部直方图均衡化后的分量得到结果图像
In = cat(3, g1, g2, g3);

% 结果显示
if flag
    figure;
    subplot(2, 2, 1); imshow(I); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(In); title('处理后的图像', 'FontWeight', 'Bold');
    % 灰度化，用于计算直方图
    Q = rgb2gray(I);
    W = rgb2gray(In);
    subplot(2, 2, 3); imhist(Q, 64); title('原灰度直方图', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imhist(W, 64); title('处理后的灰度直方图', 'FontWeight', 'Bold');
end

function g = GetLocalHisteq(I)
% 对灰度图像进行局部直方图均衡化
% 输入参数：
% I——图像矩阵
% 输出参数：
% g——结果图像

% 调用库函数 adapthisteq，执行局部均衡化增强
g = adapthisteq(I,'clipLimit',0.02,'Distribution','rayleigh');
