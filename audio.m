[x1,Fs] = audioread('sample.mp3');
 ip=x1(:,1);
figure;
stem(abs(fft(ip)));
title('input');
xlabel('n');
ylabel('x[n]');

fpass=1000;
fstop= 1500;
fs=8000;
wpass=(2*fpass)/fs;
wstop=(2*fstop)/fs;
d1=0.9;
d2=50;
wc=(fpass+fstop)*2*pi/(2*fs);
tb=((fstop-fpass)*2*pi)/fs;
N=(8*pi)/tb;
h=zeros(1,N);

for n=1:N
    h(n)=sin(wc*(n-ceil(N/2)))/(pi*(n-ceil(N/2)));
end
h(ceil(N/2))=wc/pi;
p=1-wc/pi;
w=hamming(N);

hw0=h.*w';              %after windowing
ylpf=conv(ip,hw0);       %passing through LPF
f1=downsample(ylpf,2);  %downsampled by 2
f2=upsample(f1,2);      %upsampled by 2

y1=conv(f2,hw0);    %bank1 lpf out
% figure;
% stem(abs(fft(y1)));

h2=-h;    %HPF impulse response
h2(ceil(N/2))=p;
hw1=h2.*w';   %after windowing
yhpf=conv(ip,hw1);    %passing through HPF
f3=downsample(yhpf,2);   %downsampled by 2  
f4=upsample(f3,2);     %upsampled by 2
y3=conv(f4,hw1);   %HPF out

res=y1+y3;  
figure;
stem(abs(fft(res)));
title('Recovered signal');
xlabel('n');
ylabel('y[n]');
sound(res,Fs);


