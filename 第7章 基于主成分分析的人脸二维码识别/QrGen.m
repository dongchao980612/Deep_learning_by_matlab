function outimg = QrGen(doctext, width, height)
% QrGen ���ɶ�ά��ͼ��
%
% ����:
%   doctext (string or numeric array): Ҫ������ı�����ֵ����
%   width (int): ��ά��Ŀ�ȣ�Ĭ��Ϊ400
%   height (int): ��ά��ĸ߶ȣ�Ĭ��Ϊ400
%
% ����ֵ:
%   outimg (matrix): ���ɵĶ�ά��ͼ�����0��ʾ��ɫ��1��ʾ��ɫ

% ����Ĭ�ϲ���
if nargin < 3
    height = 400;
end
if nargin < 2
    width = 400;
end
if nargin < 1
    doctext = 'hello';
end

% ȷ�� doctext ���ַ���
if ~ischar(doctext)
    str = '';
    for i = 1:length(doctext)
        str = sprintf('%s %.1f', str, doctext(i));
    end
    doctext = str;
end

% ��ȡ zxing_encrypt.jar ��·��
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing_encrypt.jar');

% �����������ȷ���ں�������ʱ�Ƴ� Java ·��
c = onCleanup(@()javarmpath(zxingpath));

% ��� zxing_encrypt.jar �� Java ·��
javaaddpath(zxingpath);

% ���� QRCode ������
writer = com.google.zxing.MultiFormatWriter();

% ���ɶ�ά��λ����
bitmtx = writer.encode(doctext, com.google.zxing.BarcodeFormat.QR_CODE, width, height);

% ��λ����ת��Ϊ�ַ�����
outimg = char(bitmtx);

% ����
clear bitmtx writer

% �����ַ�����
outimg(outimg == 10) = []; % �Ƴ����з�
outimg = reshape(outimg(1:2:end), width, height)'; % ���ܾ���
outimg(outimg ~= 'X') = 1; % ���� 'X' ���ַ��滻Ϊ 1
outimg(outimg == 'X') = 0; % �� 'X' �滻Ϊ 0
outimg = double(outimg); % ���ַ�����ת��Ϊ˫���Ⱦ���
end