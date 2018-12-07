 clc 
clear all;
close all;

f=rgb2gray(imread('lena_bw1.png'));
g=im2double(f);

 img(:,:)=g;
 [r,c]=size(img);
 order = 50; 
 n = 0:order;
 hlpf = sin(0.5*pi.*(n-(order/2)))./(pi.*(n-(order/2)));
 hlpf((order/2)+1) = 0.5;
 hlpf2=ftrans2(hlpf);
 hhpf = -hlpf;
 hhpf((order/2)+1) = 1 + hhpf((order/2)+1);
 hhpf2=ftrans2(hhpf);

ay_lpf = filter2(hlpf2,img);
ay_hpf = filter2(hhpf2,img);

ay_lpf_merge(:,:,1)=ay_lpf;
ay_hpf_merge(:,:,1)=ay_hpf;

dlpf = ay_lpf(1:2:r,1:2:c);
dhpf = ay_hpf(1:2:r,1:2:c);

dlpf_merge(:,:,1)=dlpf;
dhpf_merge(:,:,1)=dhpf;

ulpf = zeros(r,c);
uhpf = zeros(r,c);

for i = 1:r/2
    for j = 1:c/2
        ulpf(2*i,2*j) = 2.*dlpf(i,j);
        ulpf(2*i-1,2*j-1) = 2.*dlpf(i,j);
        uhpf(2*i,2*j) = 2.*dhpf(i,j);
        uhpf(2*i-1,2*j-1) = 2.*dhpf(i,j);
    end
end

sy_lpf = filter2(hlpf2,ulpf); 
sy_hpf = filter2(hhpf2,uhpf);

final= sy_lpf+sy_hpf;

imgc=final;

figure, imshow(g);
title('Original image');
figure, imshow(imgc);
title('Reconstructed image');

figure,
subplot(2,2,1),
imshow(ay_lpf);title('Output of analysis low pass filter');
subplot(2,2,3),
imshow(sy_lpf);title('Output of synthesis low pass filter');
subplot(2,2,2),
imshow(dlpf);title('Output of down sampler-low pass');
subplot(2,2,4),
imshow(ulpf);title('Output of up sampler-low pass');

figure,
subplot(2,2,1),
imshow(ay_hpf);title('Output of analysis high pass filter');
subplot(2,2,3),
imshow(sy_hpf);title('Output of synthesis high pass filter');
subplot(2,2,2),
imshow(dhpf);title('Output of down sampler-high pass');
subplot(2,2,4),
imshow(uhpf);title('Output of up sampler-high pass');

