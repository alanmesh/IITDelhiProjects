clear;
%% Import and Convert Images
img=imread('dog.jpg');
img=rgb2gray(img);
img=imresize(img,[100,100]);
img=uint8(img);
[m,n]=size(img);
%Entropy Function
entropy=Entropy(img);
%Minimum average bits per pixel is equal to entropy


%% Huffman Encoding and Decoding
symbols=0:255;
[count,bins]=imhist(img);
pf=count/sum(count);
d=huffmandict(symbols,pf);
newVec=reshape(img,1,m*n);
hEncodig=huffmanenco(newVec,d);
hDecoding=huffmandeco(hEncodig,d);
hDecoding=reshape(hDecoding,[m,n]);
% Plot
figure
subplot(1,2,1),imshow(img),title('Original Image');
subplot(1,2,2),imshow(hDecoding,[ ]),title('Huffman Decoded image');

%% Golomb Encoding and Decoding
[gEnc,M]=Golomb(img);
gDec=GolombDeco(gEnc,M);
figure 
subplot(1,2,1),imshow(img),title('Original Image');
subplot(1,2,2),imshow(gDec,[ ]),title('Golomb Decoded image');

%% Arithmatic coding and Decoding
newVec=int16(newVec);
for i=1:m*n
    if(newVec(i)==0)
        newVec(i)=1;
    end
end
for i=1:256
    if(count(i)==0)
        count(i)=1;
    end
end
aEnc=arithenco(newVec,count);
aDec=arithdeco(aEnc,count,m*n);
aDec=reshape(aDec,[m,n]);
figure
subplot(1,2,1),imshow(img),title('Original Image');
subplot(1,2,2),imshow(aDec,[ ]),title('Arithmetic Decoded image');

%% LZW Encoding and Decoding
[LZW_Enc,M]=norm2lzw(img);
LZW_Dec=lzw2norm(LZW_Enc);
LZW_Dec=reshape(LZW_Dec,[100,100]);
figure 
subplot(1,2,1),imshow(img),title('Original Image');
subplot(1,2,2),imshow(LZW_Dec,[ ]),title('LZW Decoded image');

