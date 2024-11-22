function outimg = QrGen(doctext, width, height)
% QrGen 生成二维码图像
%
% 参数:
%   doctext (string or numeric array): 要编码的文本或数值数组
%   width (int): 二维码的宽度，默认为400
%   height (int): 二维码的高度，默认为400
%
% 返回值:
%   outimg (matrix): 生成的二维码图像矩阵，0表示白色，1表示黑色

% 设置默认参数
if nargin < 3
    height = 400;
end
if nargin < 2
    width = 400;
end
if nargin < 1
    doctext = 'hello';
end

% 确保 doctext 是字符串
if ~ischar(doctext)
    str = '';
    for i = 1:length(doctext)
        str = sprintf('%s %.1f', str, doctext(i));
    end
    doctext = str;
end

% 获取 zxing_encrypt.jar 的路径
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');

% 添加清理函数，确保在函数结束时移除 Java 路径
c = onCleanup(@()javarmpath(zxingpath));

% 添加 zxing_encrypt.jar 到 Java 路径
javaaddpath(zxingpath);

% 创建 QRCode 编码器
writer = com.google.zxing.MultiFormatWriter();

% 生成二维码位矩阵
bitmtx = writer.encode(doctext, com.google.zxing.BarcodeFormat.QR_CODE, width, height);

% 将位矩阵转换为字符矩阵
outimg = char(bitmtx);

% 清理
clear bitmtx writer

% 处理字符矩阵
outimg(outimg == 10) = []; % 移除换行符
outimg = reshape(outimg(1:2:end), width, height)'; % 重塑矩阵
outimg(outimg ~= 'X') = 1; % 将非 'X' 的字符替换为 1
outimg(outimg == 'X') = 0; % 将 'X' 替换为 0
outimg = double(outimg); % 将字符矩阵转换为双精度矩阵
end