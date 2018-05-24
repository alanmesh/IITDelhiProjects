%% Histogram Plotter and Histogram Equalizer
clear;

%% Plotter use HistogramPlotter function
a=imread('16bit.bmp'); % Read the Image
b=HistogramPlotter(a); % Use the created function from correspoinging HistogramPlotter.m file

%% Plot the Image with its histogram

meanA= mean2(a);
sdA= std2(a);

figure
subplot(1,2,1), imshow(uint8(a)),title(['Mean= ',num2str(meanA),'SD= ',num2str(sdA)]);

subplot(1,2,2), bar(b), title('Histogarm of original image');



%% Code for Equlizer
Image=a;

%% Build histogram

A=a;


pixCount=size(A,1)*size(A,2);

finalImage=uint8(zeros(size(A,1),size(A,2)));

frequency=zeros(16,1);

probDensity=zeros(16,1);

probCummulative=zeros(16,1);

cumSum=zeros(16,1);

op=zeros(16,1);


%freq counts the occurrence of each pixel value.

%The probability of each occurrence is calculated by probf.


for i=1:size(A,1)

    for j=1:size(A,2)

        value=A(i,j);

        frequency(value+1)=frequency(value+1)+1;

        probDensity(value+1)=frequency(value+1)/pixCount;

    end

end


sum=0;

noOfLevel=16;


%The cumulative distribution probability is calculated. 

for i=1:size(probDensity)

   sum=sum+frequency(i);

   cumSum(i)=sum;

   probCummulative(i)=cumSum(i)/pixCount;

   op(i)=round(probCummulative(i)*noOfLevel);

end

for i=1:size(A,1)

    for j=1:size(A,2)

            finalImage(i,j)=op(A(i,j)+1);

    end

end
meanB= mean2(finalImage);
sdB= std2(finalImage);
figure
subplot(1,2,1), imshow(finalImage), title(['Mean= ',num2str(meanB),'SD= ',num2str(sdB)]);
subplot(1,2,2), bar(HistogramPlotter(finalImage)),title('H of Equalized Image');


%% Histogram matching

PDF = [0.0 0.0 0.1 0.25 0.10 0.10 0.20 0.05 0.05 0.05 0.05 0.10 0.05 0.10 0.05 0.05];
cummulativeArr=zeros(1,16);
cummulativeArr(1)=0;
newArr=zeros(1,16);
newArr(1)=0;

for u=2:16
    cummulativeArr(u)=cummulativeArr(u-1)+PDF(u);
    newArr(u)= floor(15*cummulativeArr(u));
end

for i=1:size(A,1)

    for j=1:size(A,2)

            finalImageM(i,j)=newArr(A(i,j)+1);

    end

end

meanC= mean2(finalImageM);
sdC= std2(finalImageM);

figure
subplot(1,2,1), imshow(finalImageM), title(['Mean= ',num2str(meanC),'SD= ',num2str(sdC)]);
subplot(1,2,2), bar(newArr),title('Matched Image');




