clear;
%% Read and convert image
I=imread('cameraman.tif');
I=im2double(I);
%% K L Transform
z=1;
for i=1:8:256
    for j=1:8:256
        for x=0:7
            for y=0:7
            img(x+1,y+1)=I(i+x,j+y);
            end
        end
            k=0;
            for l=1:8
                iEX{k+1}=img(:,l)*img(:,l)';
                k=k+1;
            end
            iExpectation=zeros(8:8);
            for l=1:8
                iExpectation=iExpectation+(1/8)*iEX{l};
            end
            iMean=zeros(8,1);
            for l=1:8
                iMean=iMean+(1/8)*img(:,l);
            end
            imeanT=iMean*iMean';
            iCV=iExpectation - imeanT;
            [a{z},b{z}]=eig(iCV);
            temp=a{z};
             z=z+1;
            for l=1:8
                a{z-1}(:,l)=temp(:,8-(l-1));
            end
             for l=1:8
           iTrans(:,l)=a{z-1}*img(:,l);
             end
           for x=0:7
               for  y=0:7
                   iTransfromed(i+x,j+y)=iTrans(x+1,y+1);
               end
           end
mask=[1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 ];
  
  iTemp=iTrans.*mask;
           for l=1:8
           iInverseTrans(:,l)=a{z-1}'*iTemp(:,l);
           end
            for x=0:7
               for  y=0:7
                  iInvTransformed(i+x,j+y)=iInverseTrans(x+1,y+1);
               end
           end

          end
end

  
%% Discrete Cosine Transform Coding
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[8 8],invdct);


%% DFT Coding
N=8;
for i=1:8:256
    for j=1:8:256
        for x=0:7
            for y=0:7
                img(x+1,y+1)=I(i+x,j+y);
            end
        end
        F=fft2(img);
         for x=1:8
             for y=1:8
                 if(log(abs(F(x,y))+1)<0.01*log(max(abs(F)))+1)
                     F(x,y)=0;
                 end
             end
         end
        img=real(ifft2(F));
        for x=0:7
            for y=0:7
                J(i+x,j+y)=img(x+1,y+1);
            end
  
        end
    end
end


%% Entropy Calculation
eKL=Entropy(iInvTransformed)
eDCT=Entropy(I2);
eDFT=Entropy(J);

disp(['Entropy of KL= ' ,num2str(eKL)]);
disp(['Entropy of DCT= ' ,num2str(eDCT)]);
disp(['Entropy of DFT= ' ,num2str(eDFT)]);


%% Root Mean Square Error
rmsKL=RMS(I,iInvTransformed);
rmsDCT=RMS(I,I2);
rmsDFT=RMS(I,J);
disp(['Root Mean Sqaure Error in KL= ' ,num2str(rmsKL)]);
disp(['Root Mean Sqaure Error in DCT= ' ,num2str(rmsDCT)]);
disp(['Root Mean Sqaure Error in DFT= ' ,num2str(rmsDFT)]);
%% Square-Mean Signal-to-Noise Ratios
snrKL=snr(I,abs(iInvTransformed-I));
snrDCT=snr(I,abs(I2-I));
snrDFT=snr(I,abs(J-I));
disp(['SNR in KL= ',num2str(snrKL)]);
disp(['SNR in DCT= ' ,num2str(snrDCT)]);
disp(['SNR in DFT= ' ,num2str(snrDFT)]);

%% Plotting
  figure
  subplot(2,2,1),imshow(iTransfromed),title('KL Transformed Image');
  subplot(2,2,2),imshow(iInvTransformed),title('KL Inverse T Image');
  subplot(2,2,3),imshow(I2),title('Decompressed Cosine T');
  subplot(2,2,4),imshow(J,[ ]),title('Decompressed Fourier T');


        
        