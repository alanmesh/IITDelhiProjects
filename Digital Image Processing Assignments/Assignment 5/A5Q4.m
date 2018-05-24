%% Clearing the workspace
clear;
%% Create a new video object
videoObj = VideoReader('Time-Lapse- Watch Flowers Bloom Before Your Eyes - Short Film Showcase (1).mp4');

%% Getting new frames
filt1 = rgb2gray(read(videoObj, 201));
filt1 = im2double(filt1);
[row,col]=size(filt1);
fSp=fspecial('motion',20,45);
ci=0.1;

%% Blurring-and recovery
blurOnly=imfilter(filt1,fSp,'conv','circular');
blurredNoisy=imnoise(blurOnly,'salt & pepper',ci);
recoveryImg=deconvwnr(blurOnly,fSp,0);
signalVariance=var(filt1(:));
noiseVariance=ci*0.5;
recoverNoisy=deconvwnr(blurredNoisy,fSp,noiseVariance/signalVariance);
recoverNC=deconvwnr(blurredNoisy,fSp,1.5);

padAr=[0 -1 0;-1 4 -1;0 -1 0];
padAr=padarray(padAr,[row-3 col-3],0,'post');
cont=0.1;
temp1=fft2(padAr);
temp1=fftshift(temp1);
recoverNewCLS=deconvwnr(blurredNoisy,fSp,abs(cont*temp1));
noiseMean=0;


wgnVariance=0.00001;
blurredNoisyWGN=imnoise(blurredNoisy,'gaussian',noiseMean,wgnVariance);
recoverNoisyWGN=deconvwnr(blurredNoisyWGN,fSp,(noiseVariance+wgnVariance)/signalVariance);
recoverNoisyWGNCon=deconvwnr(blurredNoisyWGN,fSp,1.5);
recoverCLSWGN=deconvwnr(blurredNoisyWGN,fSp,abs(cont*temp1));

%% Plotting final results
figure
subplot(2,3,1),imshow(filt1);
subplot(2,3,2),imshow(blurOnly);
subplot(2,3,3),imshow(blurredNoisy);
subplot(2,3,4),imshow(recoveryImg);
subplot(2,3,5),imshow(recoverNoisy);
subplot(2,3,6),imshow(recoverNC);
figure
imshow(recoverNewCLS);
figure
subplot(2,2,1),imshow(blurredNoisyWGN);
subplot(2,2,2),imshow(recoverNoisyWGN);
subplot(2,2,3),imshow(recoverNoisyWGNCon);
subplot(2,2,4),imshow(recoverCLSWGN);