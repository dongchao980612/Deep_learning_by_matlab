clc;clear ;close ;

file = './wav/Test/¼��.m4a';

[signal, fs] = audioread(file);
disp(fs);

S = GetDatabase();

[num, MC] = Reco(S, file);
result = S(num).name;
% result = result(1:2);
disp(result)

