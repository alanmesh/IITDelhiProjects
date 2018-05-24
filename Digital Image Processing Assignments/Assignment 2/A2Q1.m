% subplot(1,2,1);imshow(Img);title('Original image');
% subplot(1,2,2);imagesc(logImg), colormap gray;title('log of image');


clear;
Img=imread('tyre.tif'); %This will reads the image to i
figure
imhist(Img);
%% Negative of Image
NegativeImg=imcomplement(Img);
figure
subplot(1,1,1);imshowpair(Img,NegativeImg,'montage');title('Original Vs Negative of Image');

%% Log of image
logImg= log(1+double(Img));
figure
subplot(1,1,1);imshowpair(Img,logImg,'montage');title('Original Vs log of Image');

%% Gamma corrected images
i1= imadjust(Img,[],[],0.4);
i2= imadjust(Img,[],[],2.5);
i3= imadjust(Img,[],[],10);
i4= imadjust(Img,[],[],25);
i5= imadjust(Img,[],[],100);
figure
subplot(2,3,1);imshow(Img);title('Original image');
subplot(2,3,2);imshow(i1);title('gamma= 0.4');
subplot(2,3,3);imshow(i2);title('gamma= 2.5');
subplot(2,3,4);imshow(i3);title('gamma= 10');
subplot(2,3,5);imshow(i4);title('gamma= 25');
subplot(2,3,6);imshow(i5);title('gamma= 100');

%% Plane Slicing
B1=bitget(Img,1);
B2=bitget(Img,2);
B3=bitget(Img,3);
B4=bitget(Img,4);
B5=bitget(Img,5);
B6=bitget(Img,6);
B7=bitget(Img,7);
B8=bitget(Img,8);
figure
subplot(2,4,1);imshow(logical(B1));title('Bit plane 1');
subplot(2,4,2);imshow(logical(B2));title('Bit plane 2');
subplot(2,4,3);imshow(logical(B3));title('Bit plane 3');
subplot(2,4,4);imshow(logical(B4));title('Bit plane 4');
subplot(2,4,5);imshow(logical(B5));title('Bit plane 5');
subplot(2,4,6);imshow(logical(B6));title('Bit plane 6');
subplot(2,4,7);imshow(logical(B7));title('Bit plane 7');
subplot(2,4,8);imshow(logical(B8));title('Bit plane 8');
%% Part C
ImgDiv= Img./2;
ImgMul= Img.*2;
reducedContrast= imadjust(Img,[0;1],[0.5; 0.75]);
figure
subplot(2,2,1);imshow(Img);title('Original Image');
subplot(2,2,2);imshow(ImgDiv);title('Darker Image');
subplot(2,2,3);imshow(ImgMul);title('Brighter Image');
subplot(2,2,4);imshow(reducedContrast);title('Reduced Constast');
figure
subplot(2,2,1);imhist(Img);title('Original Image');
subplot(2,2,2);imhist(ImgDiv);title('Darker Image');
subplot(2,2,3);imhist(ImgMul);title('Brighter Image');
subplot(2,2,4);imhist(reducedContrast);title('Reduced Constast');

eqImg=histeq(Img);
subplot(1,2,1);imshow(Img);title('Equalized Image');
subplot(1,2,2);imhist(Img);title('Histogram of Equalized Image');

%% Highlighting levels 120-200
[m,n]=size(Img);
specificH = Img;

for i=1:m
    for j=1:n
        if(Img(i,j)>=120)
            if(Img(i,j)<=200)
                specificH(i,j)=200;
            end
        end
    end
end
figure
subplot(1,1,1);imshowpair(Img,specificH,'montage');title('Original Vs Highlighted Image between 120-200');




