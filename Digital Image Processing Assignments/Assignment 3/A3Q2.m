clear;
%%
I=imread('circuit.tif');
J=double(I);
ImageCopy=I;
%%
img=imread('circuit.tif');
 sizIm = size(img);
    m = sizIm(1);
    n = sizIm(2);
    col = zeros(m,1);
    row = zeros(1,n+2);
    imgn = [col img col];
    imgn = [row;imgn;row];
    
   
    tmpIm = img;%Laplacian using filter without diagonal entries
    for i=2:n+1
        for j=2:m+1
            tmp = imgn(j,i-1) + imgn(j,i+1) + imgn(j-1,i) + imgn(j+1,i) - 4*imgn(j,i);
            tmpIm(j-1,i-1) = tmp;
        end
    end

    %Laplacian without diagonal entries
    %Laplacian filter used [1 1 1;1 -8 1;1 1 1]
    tmpIm2 = img;%Laplacian using filter with diagonal entries
    imgn = [col img col];
    imgn = [row;imgn;row];
    for i=2:n+1
        for j=2:m+1
            tmp = imgn(j,i-1) + imgn(j,i+1) + imgn(j-1,i) + imgn(j+1,i) + imgn(j-1,i-1) + imgn(j+1,i+1) + imgn(j-1,i+1) + imgn(j+1,i-1) - 8*imgn(j,i);
            tmpIm2(j-1,i-1) = tmp;
        end
    end
   
%% Gradient Operators
filter3=edge(ImageCopy,'Roberts'); % Robert's Cross OP
filter4=edge(ImageCopy,'Sobel'); % Sobel's OP

%% Implementing High Boost Filtering
[row ,columns]=size(ImageCopy);
I=1.1;
for j=i:row
    for j=1:columns
        if(ImageCopy(i,j)<0)
            newMask1=[0 -1 0;-1 I+4 -1;0 -1 0];
            filterImaged=imfilter(ImageCopy,newMask1);
        end
        if(ImageCopy(i,j)>=0)
            newMask2=[-1 -1 -1;-1 I+8 -1;-1 -1 -1];
            filterImaged=imfilter(ImageCopy,newMask2);
        end
    end
end
filter5=filterImaged;
%% High pass
kernel2 = [-1 -2 -1; -2 12 -2; -1 -2 -1]/16;
% Filter the image.  Need to cast to single so it can be floating point
% which allows the image to have negative values.

filteredImageHP = imfilter(single(imread('circuit.tif')), kernel2);
figure
imshow(filteredImageHP, []),title('High pass Filter');
% Display the image.

%% plot all the filters
figure 
subplot(2,3,1);imshow(ImageCopy);title('Original Image')
subplot(2,3,2);imshow(tmpIm);title('Laplacian filter')
subplot(2,3,3);imshow(tmpIm2);title('With diagonal terms')
subplot(2,3,4);imshow(filter3);title('Robert''s operator')
subplot(2,3,5);imshow(filter4);title('Sobel''s operator')
subplot(2,3,6);imshow(filter5);title('High boost filter')