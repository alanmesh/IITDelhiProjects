
%% Reading the image and converting to grayscale
img = imread('autumn.tif');
img=rgb2gray(img);
img = uint8(img);


[row,col]=size(img);
windSize=9; 
dAngle=45;
%% motionblur
mBlur=motionblur(dAngle,windSize);

%% fast fourier tranform
fastF=fft2(img);

%% Inverse filtering
H=fft2(mBlur,row,col);
G=fastF.*H;
invFastF=ifft2(G);
figure(1),
subplot(121),imagesc(img),colormap('gray'),title('Original Image')
subplot(122),imagesc(abs(invFastF)),colormap('gray'),title('Blurred Image')
figure(2),
subplot(212),imagesc(log(1+abs(G))),colormap('gray'),title('Blurring Filter')
subplot(211),imagesc(mBlur),colormap('gray'),title('Blurring Filter Mask')

P = H;
P( P==0 )=1e-7; 
hINverse = 1./(P);
GG = fft2(invFastF);
recByInverse = ifft2(GG.*hINverse);
figure(3)
subplot(2,1,1)
imagesc(abs(recByInverse)), colormap('gray'), title('Inverse Filtering')
%% Pusedo inverse filtering
P = H;
epsilon = 1e-3;
P(abs(P) < epsilon) = 0;
hINverse = 1./(P);
hINverse(isinf(hINverse)) = 0;
GG = fft2(invFastF);
rec1 = ifft2(GG.*hINverse);
figure(3)
subplot(2,1,2)
imagesc(abs(rec1)), colormap('gray'), title('pseudo inverse filtering')
