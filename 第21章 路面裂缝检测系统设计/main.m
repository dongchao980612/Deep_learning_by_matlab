clc;clear;close all;

% 读取图像
I = imread('./images/image.png');

% 调用主函数处理图像
Result = Process_Main(I);

% 创建一个新的图形窗口
figure;

% 子图 1: 输入图像（灰度化）
subplot(3, 3, 1);
imshow(Result.Image);
title('输入图像（灰度化）');

% 子图 2: 直方图增强
subplot(3, 3, 2);
imshow(Result.hist);
title('直方图增强');

% 子图 3: 中值滤波
subplot(3, 3, 3);
imshow(Result.Medfilt);
title('中值滤波');

% 子图 4: 图像增强
subplot(3, 3, 4);
imshow(Result.Enance);
title('图像增强');

% 子图 5: 二值图像
subplot(3, 3, 5);
imshow(Result.Bw);
title('二值图像');

% 子图 6: 二值图像滤波
subplot(3, 3, 6);
imshow(Result.BwFilter);
title('二值图像滤波');

% 子图 7: 裂缝识别
subplot(3, 3, 7);
imshow(Result.CrackRec);
title('裂缝识别');

% 子图 8: 裂缝判断
subplot(3, 3, 8);
imshow(Result.CrackJudge);
title('裂缝判断');

% 子图 9: 裂缝拼接
subplot(3, 3, 9);
imshow(Result.CrackBridge);
title('裂缝拼接');

% 在裂缝拼接图中标注 BwLength
hold on;
rectangle('Position', Result.rect, 'EdgeColor', 'r', 'LineWidth', 2);
text(Result.rect(1), Result.rect(2), sprintf('BwLength: %.2f', Result.BwLength), ...
     'Color', 'r', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
hold off;

% 显示裂缝形状信息
disp(['裂缝形状: ', Result.str]);

% 显示面积信息
disp(['面积信息: ', num2str(Result.BwArea)]);

% 显示宽度最大值和最小值
disp(['宽度最大值: ', num2str(Result.BwWidthMax)]);
disp(['宽度最小值: ', num2str(Result.BwWidthMin)]);

% 显示阈值信息
disp(['阈值信息: ', num2str(Result.BwTh)]);