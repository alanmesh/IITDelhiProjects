clear;
img=imread('circuit.tif'); % Read image

%% Compute fourier tsiransform and plot

imgF=fourierPlotter(img);
%% Translate and plot fourier transform
J = imtranslate(img,[15, 25]);
jF=fourierPlotter(J);
%% Rotate image and plot fourier transform
Q= imrotate(img,20);

qF=fourierPlotter(Q);
%% Resize 
D= imresize(img,2);
dF=fourierPlotter(D);
%% Butterworth
filtered_imageHigh = butterworthbpf(img,110,120,4);
filtered_imageLow = butterworthbpf(img,10,20,4);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100,700 , 300]);
subplot(1,3,1),imshow(img,[]),title('Original');
subplot(1,3,2),imshow(filtered_imageHigh,[]),title('High Pass Butterworth');
subplot(1,3,3),imshow(filtered_imageLow,[]),title('Low Pass Butterworth');
%% Ideal Filter
l=IdealLowPass(img,0.2);
h=IdealLowPass(img,2.2);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 500, 300]);
subplot(1,3,1),imshow(img,[]),title('Original');
subplot(1,3,2),imshow(h,[]),title('High Pass Ideal');
subplot(1,3,3),imshow(l,[]),title('Low Pass Ideal');



%% Plot the above three reuslts
FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1000, 600]);
subplot(2,4,1), imshow(img), title('(a)Original Image');
subplot(2,4,2), imshow(J), title('(b)Translated Image');
subplot(2,4,3), imshow(Q), title('(c)Rotated Image');
subplot(2,4,4), imshow(D),title('Upscaled (d)');
subplot(2,4,5), imshow(imgF), title('Fourier transform (a)');
subplot(2,4,6), imshow(jF), title('Fourier transform (b)');
subplot(2,4,7), imshow(qF), title('Fourier transform (c)');
subplot(2,4,8),imshow(dF),title('Fourier tranform (d)');




%% Gaussian Filter
G1 = imgaussfilt(img,2);
G2 = imgaussfilt(img,0.5);
figure
subplot(1,2,1), imshow(G1),title('Low pass Gaussian, sigma= 2');
subplot(1,2,2),imshow(G2),title('Low pass Gaussian, sigma=0.5');

%% High pass
figure
subplot(1, 3, 1);imshow(img, []); title('Original image');
% Filter 1
kernel1 = -1 * ones(3)/9;
kernel1(2,2) = 8/9;
% Filter the image.  Need to cast to single so it can be floating point
% which allows the image to have negative values.
filteredImage = imfilter(single(img), kernel1);
% Display the image.
subplot(1, 3, 2);
imshow(filteredImage, []),title('High pass Filter 1');

% Filter 2
kernel2 = [-1 -2 -1; -2 12 -2; -1 -2 -1]/16;
% Filter the image.  Need to cast to single so it can be floating point
% which allows the image to have negative values.
filteredImage = imfilter(single(img), kernel2);
% Display the image.
subplot(1, 3, 3);
imshow(filteredImage, []),title('High pass Filter 2');

  