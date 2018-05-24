%% Reading the image
clear all;
img = rgb2gray(imread('autumn.tif'));

%% Adding salt and pepper noise
noisyImg = imnoise(img,'salt & pepper');
%% Filters
% Adaptive median filter
amf = adpmedian(noisyImg, 3);

% Contra-harmonic filter
chf1 = spfilt(noisyImg, 'chmean', 3, 3, -1);
chf2 = spfilt(noisyImg, 'chmean', 3, 3, 5);
% Median filter
medianf = medfilt2(noisyImg);
img=im2double(img);
chf1=im2double(chf1);
chf2=im2double(chf2);
medianf=im2double(medianf);
amf=im2double(amf);
%% Computing the error
err1 = immse(img,chf1)
err2 = immse(img,chf2)
err3 = immse(img,medianf)
err4 = immse(img,amf)

sn1 = snr2(img,chf1-img);
sn2 = snr2(img,chf2-img);
sn3 = snr2(img,medianf-img);
sn4 = snr2(img,amf-img);

%% Plotting the results
figure;
subplot(3,2,1),imshow(img);
subplot(3,2,2),imshow(noisyImg);
subplot(3,2,3),imshow(chf1);
subplot(3,2,4),imshow(chf2);
subplot(3,2,5),imshow(medianf);
subplot(3,2,6),imshow(amf);
e = [err1,err2,err3,err4];
r = [sn1,sn2,sn3,sn4];
figure
plot(r,e);


