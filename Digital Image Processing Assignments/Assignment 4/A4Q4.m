clear;
%% Read and Resize
img=imread('dog.jpg');
img=imresize(img,[100,100]);

%% Find DCT

Z(:,:,1)=dct2(img(:,:,1));
Z(:,:,2)=dct2(img(:,:,2));
Z(:,:,3)=dct2(img(:,:,3));
  for i=1:100
      for j=1:100
          if((i+j)>60)
               Z(i,j,1)=0;
               Z(i,j,2)=0;
               Z(i,j,3)=0;
           end
      end
  end
  
%% find inverse DCT
K(:,:,1)=idct2(Z(:,:,1));
K(:,:,2)=idct2(Z(:,:,2));
K(:,:,3)=idct2(Z(:,:,3));

%% Plot
 FigHandle = figure;
  set(FigHandle, 'Position', [100, 100, 1000, 400]);
subplot(1,4,1),imshow(uint8(K)),title('70% compression');
%% Next
Z(:,:,1)=dct2(img(:,:,1));
Z(:,:,2)=dct2(img(:,:,2));
Z(:,:,3)=dct2(img(:,:,3));
  for i=1:100
      for j=1:100
          if((i+j)>100)
              Z(i,j,1)=0;
              Z(i,j,2)=0;
              Z(i,j,3)=0;
          end
      end
 end
K(:,:,1)=idct2(Z(:,:,1));
K(:,:,2)=idct2(Z(:,:,2));
K(:,:,3)=idct2(Z(:,:,3));
%% Plot
subplot(1,4,2),imshow(uint8(K)),title('50% compression');
%% Next
Z(:,:,1)=dct2(img(:,:,1));
Z(:,:,2)=dct2(img(:,:,2));
Z(:,:,3)=dct2(img(:,:,3));
  for i=1:100
      for j=1:100
          if((i+j)>140)
               Z(i,j,1)=0;
               Z(i,j,2)=0;
               Z(i,j,3)=0;
          end
      end
end
K(:,:,1)=idct2(Z(:,:,1));
K(:,:,2)=idct2(Z(:,:,2));
K(:,:,3)=idct2(Z(:,:,3));
% Plot
subplot(1,4,3),imshow(uint8(K)),title('30% compression');
%% Next
Z(:,:,1)=dct2(img(:,:,1));
Z(:,:,2)=dct2(img(:,:,2));
Z(:,:,3)=dct2(img(:,:,3));
  for i=1:100
      for j=1:100
          if((i+j)>180)
              Z(i,j,1)=0;
              Z(i,j,2)=0;
              Z(i,j,3)=0;
          end
      end
 end
K(:,:,1)=idct2(Z(:,:,1));
K(:,:,2)=idct2(Z(:,:,2));
K(:,:,3)=idct2(Z(:,:,3));
subplot(1,4,4);
%% Plot
subplot(1,4,4),imshow(uint8(K)),title('10% compression');


 %% Fast Fourier Transform
Z(:,:,1)=fft2(img(:,:,1));
Z(:,:,2)=fft2(img(:,:,2));
Z(:,:,3)=fft2(img(:,:,3));
for i=1:100
      for j=1:100
          if((i+j)>60) 
               Z(i,j,1)=0; 
               Z(i,j,2)=0;
               Z(i,j,3)=0; 
           end 
        end 
end 
K(:,:,1)=ifft2(Z(:,:,1)); 
K(:,:,2)=ifft2(Z(:,:,2)); 
K(:,:,3)=ifft2(Z(:,:,3)); 
%% Plot
 FigHandle = figure;
  set(FigHandle, 'Position', [100, 100, 1000, 400]);
subplot(1,4,1),imshow(uint8(K)); 
title('70% compression FFT'); 
%% Next
Z(:,:,1)=fft2(img(:,:,1)); 
Z(:,:,2)=fft2(img(:,:,2)); 
Z(:,:,3)=fft2(img(:,:,3)); 
for i=1:100 
    for j=1:100
        if((i+j)>100) 
            Z(i,j,1)=0; 
            Z(i,j,2)=0; 
             Z(i,j,3)=0; 
        end 
     end 
end 
K(:,:,1)=ifft2(Z(:,:,1)); 
K(:,:,2)=ifft2(Z(:,:,2)); 
K(:,:,3)=ifft2(Z(:,:,3)); 
%% Plot
subplot(1,4,2),imshow(uint8(K)),title('50% compression FFT'); 
%% Next

 Z(:,:,1)=fft2(img(:,:,1));
Z(:,:,2)=fft2(img(:,:,2)); 
Z(:,:,3)=fft2(img(:,:,3)); 
for i=1:100 
   for j=1:99 
     if((i+j)>140)
         Z(i,j,:)=0;
     end
    end 
end 
K(:,:,1)=ifft2(Z(:,:,1)); 
K(:,:,2)=ifft2(Z(:,:,2)); 
K(:,:,3)=ifft2(Z(:,:,3)); 
%% Plot
subplot(1,4,3),imshow(uint8(K)),title('30% compression FFT'); 
%% Next
Z(:,:,1)=fft2(img(:,:,1)); 
Z(:,:,2)=fft2(img(:,:,2)); 
Z(:,:,3)=fft2(img(:,:,3)); 
for i=1:100 
    for j=1:100 
       if((i+j)>180) 
           Z(i,j,1)=0; 
           Z(i,j,2)=0; 
           Z(i,j,3)=0; 
        end 
     end 
end 
K(:,:,1)=ifft2(Z(:,:,1)); 
K(:,:,2)=ifft2(Z(:,:,2)); 
K(:,:,3)=ifft2(Z(:,:,3)); 
%% Plot
subplot(1,4,4),imshow(uint8(K)),title('10% compression FFT'); 