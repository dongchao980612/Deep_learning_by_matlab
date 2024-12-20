function In = RemoveFogByRetinex(I, flag)
% Retinex 实现图像去雾
% 输入参数：
% f——图像矩阵
% flag——显示标记
% 输出参数：
% In——结果图像

% 确定函数被调用时输入参数的数量
if nargin <2
    flag=1;
end

%提取图像的 R、G、B 分量
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%数据类型归一化
mr = mat2gray(im2double(R));
mg = mat2gray(im2double(G));
mb = mat2gray(im2double(B));

% *********************************************
%定义 alpha 参数
alpha = randi([80 100], 1)*20;% 1700

%定义模板大小
n = floor(min([size(I, 1) size(I, 2)])*0.5);% 258

%计算中心
n1 = floor((n+1)/2); % 129
for i = 1:n
    for j = 1:n
        %高斯函数
        b(i,j) = exp(-((i-n1)^2+(j-n1)^2)/(4*alpha))/(pi*alpha); %    258   258
    end
end

%卷积滤波
nr1 = imfilter(mr,b,'conv', 'replicate');
ng1 = imfilter(mg,b,'conv', 'replicate');
nb1 = imfilter(mb,b,'conv', 'replicate');
ur1 = log(nr1);
ug1 = log(ng1);
ub1 = log(nb1);

tr1 = log(mr);
tg1 = log(mg);
tb1 = log(mb);

yr1 = (tr1-ur1)/3;
yg1 = (tg1-ug1)/3;
yb1 = (tb1-ub1)/3;
% *********************************************

%定义 beta 参数
beta = randi([80 100], 1)*1;

%定义模板的大小
x = 32;
for i = 1:n
    for j = 1:n
        %高斯函数
        a(i,j) = exp(-((i-n1)^2+(j-n1)^2)/(4*beta))/(6*pi*beta);
    end
end

%卷积滤波
nr2 = imfilter(mr,a,'conv', 'replicate');
ng2 = imfilter(mg,a,'conv', 'replicate');
nb2 = imfilter(mb,a,'conv', 'replicate');
ur2 = log(nr2);
ug2 = log(ng2);
ub2 = log(nb2);
tr2 = log(mr);
tg2 = log(mg);
tb2 = log(mb);
yr2 = (tr2-ur2)/3;
yg2 = (tg2-ug2)/3;
yb2 = (tb2-ub2)/3;
% *********************************************

%定义 eta 参数
eta = randi([80 100], 1)*200;
for i = 1:n
    for j = 1:n
        %高斯函数
        e(i,j) = exp(-((i-n1)^2+(j-n1)^2)/(4*eta))/(4*pi*eta);
    end
end
%卷积滤波
nr3 = imfilter(mr,e,'conv', 'replicate');
ng3 = imfilter(mg,e,'conv', 'replicate');
nb3 = imfilter(mb,e,'conv', 'replicate');
ur3 = log(nr3);
ug3 = log(ng3);
ub3 = log(nb3);
tr3 = log(mr);
tg3 = log(mg);
tb3 = log(mb);
yr3 = (tr3-ur3)/3;
yg3 = (tg3-ug3)/3;
yb3 = (tb3-ub3)/3;
% *********************************************
dr = yr1+yr2+yr3;
dg = yg1+yg2+yg3;
db = yb1+yb2+yb3;
cr = im2uint8(dr);
cg = im2uint8(dg);
cb = im2uint8(db);

% 通过集成处理后的分量得到结果图像
In = cat(3, cr, cg, cb);

%结果显示
if flag
    figure;
    subplot(2, 2, 1); imshow(I); title('原图像', 'FontWeight', 'Bold');
    subplot(2, 2, 2); imshow(In); title('处理后的图像', 'FontWeight', 'Bold');
    % 灰度化，用于计算直方图
    Q = rgb2gray(I);
    M = rgb2gray(In);
    subplot(2, 2, 3); imhist(Q, 64); title('原灰度直方图', 'FontWeight', 'Bold');
    subplot(2, 2, 4); imhist(M, 64); title('处理后的灰度直方图', 'FontWeight', 'Bold');
end