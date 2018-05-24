%% Add Guassian noise to an image.
% Follwing formula is used to compute the variance of
% noise related to a particular SNR-
% var(noise) = var(image)/10^(SNR/10)
clear;
clc;
%% Reading the image
I = imread('rsz_einstein.jpg');
I= double(I);

%% Normalizing the intensities between 0 and 1
I = I - min(I(:));
I = I / max(I(:));


%% computing variance for differnt SNR
v_zero = var(I(:)) / 1;
v_ten= var(I(:)) / 10;
v_twenty=var(I(:)) / 100;
v_thirty=var(I(:)) / 1000;

%% Generating Noisy images
I_zero = imnoise(I, 'gaussian', 0, v_zero);
I_ten=  imnoise(I, 'gaussian', 0, v_ten);
I_twenty=  imnoise(I, 'gaussian', 0, v_twenty);
I_thirty=  imnoise(I, 'gaussian', 0, v_thirty);
%% Plotting the images
figure
subplot(2, 3, 1), imshow(I), title('Original image')
subplot(2, 3, 2), imshow(I_zero), title('SNR= 0')
subplot(2, 3, 3), imshow(I_ten), title('SNR= 10')
subplot(2, 3, 4), imshow(I_twenty), title('SNR= 20')
subplot(2, 3, 5), imshow(I_thirty), title('SNR= 30')

%% Smoothening opetations
tempFive=I; %Copy original image
for i=1:5
    tempFive = tempFive+ imnoise(I,'gaussian',v_ten);
end
tempFive=tempFive-I;
meanSq1=immse(tempFive/5,I); %compute Mean Squared Error
tempTen=I;  % Copy
for i=1:10
    tempTen = tempTen+ imnoise(I,'gaussian',v_ten);
end
tempTen=tempTen-I;

meanSq2= immse(tempTen/10,I); % Compute Mean Squared Error
tempFifteen=I; % Copy

for i=1:15
    tempFifteen = tempFifteen+ imnoise(I,'gaussian',v_ten);
end
tempFifteen=tempFifteen-I;
meanSq3= immse(tempFifteen/15,I); % Compute Mean Squared Error


%% Doing the plot of the Smoothened Images
figure
subplot(2,2,1),imshow(I_ten),title('SNR=10');
subplot(2,2,2),imshow(tempFive/5),title('5 Image Smooth');
subplot(2,2,3),imshow(tempTen/10),title('10 Image Smooth');
subplot(2,2,4),imshow(tempFifteen/15),title('15 Image Smooth');

Q=['Mean Square Error with 5 Image smoothening= ', num2str(meanSq1)];
disp(Q);
Q=['Mean Square Error with 10 Image smoothening= ',num2str(meanSq2)];
disp(Q);
Q=['Mean Square Error with 15 Image smoothening= ',num2str(meanSq3)];
disp(Q);


