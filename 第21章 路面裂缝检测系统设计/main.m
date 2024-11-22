clc;clear;close all;

% ��ȡͼ��
I = imread('./images/image.png');

% ��������������ͼ��
Result = Process_Main(I);

% ����һ���µ�ͼ�δ���
figure;

% ��ͼ 1: ����ͼ�񣨻ҶȻ���
subplot(3, 3, 1);
imshow(Result.Image);
title('����ͼ�񣨻ҶȻ���');

% ��ͼ 2: ֱ��ͼ��ǿ
subplot(3, 3, 2);
imshow(Result.hist);
title('ֱ��ͼ��ǿ');

% ��ͼ 3: ��ֵ�˲�
subplot(3, 3, 3);
imshow(Result.Medfilt);
title('��ֵ�˲�');

% ��ͼ 4: ͼ����ǿ
subplot(3, 3, 4);
imshow(Result.Enance);
title('ͼ����ǿ');

% ��ͼ 5: ��ֵͼ��
subplot(3, 3, 5);
imshow(Result.Bw);
title('��ֵͼ��');

% ��ͼ 6: ��ֵͼ���˲�
subplot(3, 3, 6);
imshow(Result.BwFilter);
title('��ֵͼ���˲�');

% ��ͼ 7: �ѷ�ʶ��
subplot(3, 3, 7);
imshow(Result.CrackRec);
title('�ѷ�ʶ��');

% ��ͼ 8: �ѷ��ж�
subplot(3, 3, 8);
imshow(Result.CrackJudge);
title('�ѷ��ж�');

% ��ͼ 9: �ѷ�ƴ��
subplot(3, 3, 9);
imshow(Result.CrackBridge);
title('�ѷ�ƴ��');

% ���ѷ�ƴ��ͼ�б�ע BwLength
hold on;
rectangle('Position', Result.rect, 'EdgeColor', 'r', 'LineWidth', 2);
text(Result.rect(1), Result.rect(2), sprintf('BwLength: %.2f', Result.BwLength), ...
     'Color', 'r', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
hold off;

% ��ʾ�ѷ���״��Ϣ
disp(['�ѷ���״: ', Result.str]);

% ��ʾ�����Ϣ
disp(['�����Ϣ: ', num2str(Result.BwArea)]);

% ��ʾ������ֵ����Сֵ
disp(['������ֵ: ', num2str(Result.BwWidthMax)]);
disp(['�����Сֵ: ', num2str(Result.BwWidthMin)]);

% ��ʾ��ֵ��Ϣ
disp(['��ֵ��Ϣ: ', num2str(Result.BwTh)]);