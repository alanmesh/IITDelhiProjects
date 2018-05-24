clear;
%%
I=imread('circuit.tif');
J=double(I);
ImageCopy=I;

% %% Laplacian
% ImgA=zeros(size(I));
% ImgB=zeros(size(I));
% 
% % Creating two filters
% mask1=[0 1 0;1 -4 1; 0 1 0];% Diagonal terms not included
% mask2=[1 1 1;1 -8 1; 1 1 1];% Diagonal terms included
% 
% % Pad array according to dimensions
% I=padarray(I,[1,1]);
% I=double(I);

% %% Implementaion the method
% for i=1:size(I,1)-2
%     for j=1:size(I,2)-2
%        
%         ImgA(i,j)=mask1.*I(i:i+2,j:j+2);
%         ImgB(i,j)=mask2.*I(i:i+2,j:j+2);
%        
%     end
% end
% filter1=ImgA;
% filter2=ImgB;
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
%% plot all the filters
figure 
subplot(2,3,1);imshow(ImageCopy);title('Original Image')
subplot(2,3,2);imshow(filter1);title('Laplacian filter')
subplot(2,3,3);imshow(filter2);title('With diagonal terms')
subplot(2,3,4);imshow(filter3);title('Robert''s operator')
subplot(2,3,5);imshow(filter4);title('Sobel''s operator')
subplot(2,3,6);imshow(filter5);title('High boost filter')