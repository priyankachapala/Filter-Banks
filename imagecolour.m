 clc 
clear all;
close all;

f=(imread('girl.png'));
g=im2double(f);

%%1st channel
 img(:,:)=g(:,:,1);
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
ulpf_merge(:,:,1)=ulpf;
uhpf_merge(:,:,1)=uhpf;

sy_lpf = filter2(hlpf2,ulpf); 
sy_hpf = filter2(hhpf2,uhpf);

sy_lpf_merge(:,:,1)=sy_lpf;
sy_hpf_merge(:,:,1)=sy_hpf;

final1 = sy_lpf+sy_hpf;

%2nd channel
img(:,:)=g(:,:,2);
 [r,c]=size(img);

ay_lpf = filter2(hlpf2,img);
ay_hpf = filter2(hhpf2,img);

ay_lpf_merge(:,:,2)=ay_lpf;
ay_hpf_merge(:,:,2)=ay_hpf;

dlpf = 2.*ay_lpf(1:2:r,1:2:c);
dhpf = 2.*ay_hpf(1:2:r,1:2:c);

dlpf_merge(:,:,2)=dlpf;
dhpf_merge(:,:,2)=dhpf;

ulpf = zeros(r,c);
uhpf = zeros(r,c);

for i = 1:r/2
    for j = 1:c/2
        ulpf(2*i,2*j) = dlpf(i,j);
        uhpf(2*i,2*j) = dhpf(i,j);
    end
end
ulpf_merge(:,:,2)=ulpf;
uhpf_merge(:,:,2)=uhpf;

sy_lpf = 2.*filter2(hlpf2,ulpf); 
sy_hpf = 2.*filter2(hhpf2,uhpf);

sy_lpf_merge(:,:,2)=sy_lpf;
sy_hpf_merge(:,:,2)=sy_hpf;

final2 = sy_lpf+sy_hpf;

%3rd channel
 img(:,:)=g(:,:,3);
 [r,c]=size(img);
 
ay_lpf = filter2(hlpf2,img);
ay_hpf = filter2(hhpf2,img);

ay_lpf_merge(:,:,3)=ay_lpf;
ay_hpf_merge(:,:,3)=ay_hpf;

dlpf = 2.*ay_lpf(1:2:r,1:2:c);
dhpf = 2.*ay_hpf(1:2:r,1:2:c);

dlpf_merge(:,:,3)=dlpf;
dhpf_merge(:,:,3)=dhpf;

ulpf = zeros(r,c);
uhpf = zeros(r,c);

for i = 1:r/2
    for j = 1:c/2
        ulpf(2*i,2*j) = dlpf(i,j);
        uhpf(2*i,2*j) = dhpf(i,j);
    end
end
ulpf_merge(:,:,3)=ulpf;
uhpf_merge(:,:,3)=uhpf;

sy_lpf = 2.*filter2(hlpf2,ulpf); 
sy_hpf = 2.*filter2(hhpf2,uhpf);

sy_lpf_merge(:,:,3)=sy_lpf;
sy_hpf_merge(:,:,3)=sy_hpf;

final3 = sy_lpf+sy_hpf;
 
imgc(:,:,1)=final1;
imgc(:,:,2)=final2;
imgc(:,:,3)=final3;

figure, imshow(g);
title('Original image');
figure, imshow(imgc);
title('Reconstructed image');

figure,
subplot(2,2,1),
imshow(ay_lpf_merge);title('Output of analysis low pass filter');
subplot(2,2,3),
imshow(sy_lpf_merge);title('Output of synthesis low pass filter');
subplot(2,2,2),
imshow(dlpf_merge);title('Output of down sampler-low pass');
subplot(2,2,4),
imshow(ulpf_merge);title('Output of up sampler-low pass');

figure,
subplot(2,2,1),
imshow(ay_hpf_merge);title('Output of analysis high pass filter');
subplot(2,2,3),
imshow(sy_hpf_merge);title('Output of synthesis high pass filter');
subplot(2,2,2),
imshow(dhpf_merge);title('Output of down sampler-high pass');
subplot(2,2,4),
imshow(uhpf_merge);title('Output of up sampler-high pass');


