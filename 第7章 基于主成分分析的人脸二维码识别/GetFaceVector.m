function c = GetFaceVector(img)

load(fullfile(pwd, './face_lib/model.mat'));
a = img;
[row, col] = size(a);
b=a(1:row*col); 
b=double(b);
b=b-samplemean;
c = b * base;
c = real(c);