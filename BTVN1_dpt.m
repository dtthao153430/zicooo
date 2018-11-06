
% Bai tap ve nha so 1 - DA PHUONG TIEN 
% Ho va ten: Duong Thi Thao 
% MSSV: 20153430
% Lop: Dien tu 08-K60

      % _*__*__*_ %
      
% 1) Tao file ghi am   

BB = audiorecorder(44100, 16, 1);
disp('Noi di nao: ')
recordblocking(BB, 10);
disp('Thoi duoc roi! ');
RM = getaudiodata(BB, 'double');
audiowrite('orig_input_Thao.wav', RM, 44100);

% 2) Tao file giai dieu 

fs = 44100;
t = 0:1/fs:0.69;
f = 440; 
A = .7; 
w = 90;

f_KN = 2*f; f_DC = 3*f; f_SR = f/2; f_RV = 4*f; f_TK = 2.75*f; f_KB = 3.5*f;
A_KN = 3*A; A_DC = 2*A; A_SR = A/1.75; A_RV = 4*A; A_TK = A/3; A_KB = A;
KN = A_KN*sin(2*pi*f_KN*t+ w);
DC = A_DC*sin(2*pi*f_DC*t + w);
SR = A_SR*sin(2*pi*f_SR*t + w);
RV = A_RV*sin(2*pi*f_RV*t + w);
TK = A_TK*sin(2*pi*f_TK*t + w);
KB = A_KB*sin(2*pi*f_KB*t + w);

RM_Melody = [KN DC TK KB RV DC SR TK KB SR KN RV DC KB SR TK RV KN];
RM = audioread('orig_input_Thao.wav');
MR = RM';
C1 = RM_Melody + [MR zeros(1, length(RM_Melody)-length(MR))];
soundsc(C1, 44100);

% 3) Tao pho cua giai dieu 

Y = fft(C1);
plot(abs(Y))
N = fs;
transform = fft(C1, N)/N;
magTransform = abs(transform);
faxis = linspace(-fs/2, fs/2, N);
plot(faxis, fftshift(magTransform));
title('Spectrum');
xlabel('Frequency (Hz)');
axis([0 length(faxis)/2, 0 max(magTransform)])

% 4) Tao Spectogram cho giai dieu 

win = 128; 
hop = win/2;         
nfft = win;
spectrogram(C1, win, hop, nfft, fs, 'yaxis');
title('Spectogram');
