clear all;
%% Read the image and convert
img=imread('dog.jpg');
img=rgb2gray(img);
img=uint8(img);

%% Compuing images
bit4=round(img/16)*16;
bit5=round(img/8)*8;
bit6=round(img/4)*4;
bit7=round(img/2)*2;
bit8=img;
%% Finding root mean sqaure and SNR
RootMS=zeros(1,5);
SNR=zeros(1,5);
RootMS(1)=RMS(img,bit4);
RootMS(2)=RMS(img,bit5);
RootMS(3)=RMS(img,bit6);
RootMS(4)=RMS(img,bit7);
RootMS(5)=RMS(img,bit8);
SNR(1)=snr(img,abs(bit4-img));
SNR(2)=snr(img,abs(bit5-img));
SNR(3)=snr(img,abs(bit6-img));
SNR(4)=snr(img,abs(bit7-img));
SNR(5)=snr(img,abs(bit8-img));
%% Plotting the results
figure
subplot(2,3,1),imshow(img),title('Original Image');
subplot(2,3,2),imshow(bit4),title('4-Bit UQ'); %4 bit uniform quantization
subplot(2,3,3),imshow(bit5),title('5-bit UQ');
subplot(2,3,4),imshow(bit6),title('6-bit UQ');
subplot(2,3,5),imshow(bit7),title('7-bit UQ');
subplot(2,3,6),imshow(bit8),title('8-bit UQ');
%% Graphs for comparision
i=4:8;
figure 
plot(i,RootMS);title('RMS error vs # of bits used')
figure
plot(i,SNR),title('SNR vs # Bits used')