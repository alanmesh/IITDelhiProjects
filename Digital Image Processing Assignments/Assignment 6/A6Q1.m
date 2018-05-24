%% The following program computes the sinogram of an image, and 
%  then accordinly reconstructs the imgage using the methods specified in 
%  the question.

clear;
%% Load the image and compute sinogram
image=phantom(256);
figure
imshow(image);
thetas=[0:0.5:179.5];
angularPCount  = length(thetas);
parallelPCount = size(image,1);
sinogram = zeros(parallelPCount,angularPCount);
% Start the loop
figure 
title ('Sinogram');
  % make a new figure to store the final output
for i = 1:length(thetas)
   
   % rotate image
   tmpImage      = imrotate(image,-thetas(i),'bilinear','crop');
   
   % Make the sinogram
   sinogram(:,i) = sum(tmpImage,2);
   
   % Display the sinogram
   imagesc(sinogram);
   drawnow
end
% sinogram matrix now stores the sinogram of the image under specifined
% angles

%% Backpropagation (unfiltered)

% figure out how big our picture is going to be.
pCount = size(sinogram,1);
aCount  = length(thetas); 

% Angle conversion according to matlab conventions
thetas = (pi/180)*thetas;

% This is the vector in which the backpropagated is going to be stored
backPImage = zeros(pCount,pCount);

% Middle index
midI = floor(pCount/2) + 1;

[x,y] = meshgrid(ceil(-pCount/2):ceil(pCount/2-1));

% Start the loop. Make a new figure for the backpropagated image display
figure
for i = 1:aCount
    rotCoords = round(midI + x*sin(thetas(i)) + y*cos(thetas(i)));
    indices   = find((rotCoords > 0) & (rotCoords <= pCount));
    newCoords = rotCoords(indices);
    backPImage(indices) = backPImage(indices) + sinogram(newCoords,i)./aCount;
    
    % Draw the backpropagated image
    imagesc(backPImage)
    drawnow

end

%% Reconstruction using central sliceing theorem

% slice output image stored in this matrix
fourierSliceImage = complex(zeros(pCount,pCount));

% Middle index
midCoord = (pCount+1)/2;
yFBP = ([1:pCount]) - (pCount+1)/2;

% set up filter
rampF = [floor(pCount/2):-1:0 1:ceil(pCount/2-1)];%linspace(-1,1,numOfParallelProjections);

% loop begins. Make new figure again for output
figure
for i = 1:aCount

    % figure out which projections to add to which spots
    xCR = round(midCoord - yFBP*cos(thetas(i)));
    yCR = round(midCoord - yFBP*sin(thetas(i)));
    
    % Convert 2D coords to indices. Also transpose
    newInd = sub2ind(pCount*[1 1],xCR,yCR);

    % Filter in fourier domain
    ffDomain = rampF.*fftshift( fft( fftshift(sinogram(:,i)') ) );

    % Summation in fourier domain
    fourierSliceImage(newInd) = fourierSliceImage(newInd) + ffDomain./aCount;

    % Draw the image
    imagesc(real(fourierSliceImage))
    title('Filling in fourier domain')
    drawnow

end

% Conversion to to spatial domain
finBPI = real( ifftshift(fft2(fourierSliceImage)) );

% visualization on the fly
imagesc(finBPI)
drawnow

%% Reconstruction using filtered backpropagation

% set new image for filtered back propagation
filteredBP = zeros(pCount,pCount);

% Mid index like found above
midFBP = floor(pCount/2) + 1;
[xFBP,yFBP] = meshgrid(ceil(-pCount/2):ceil(pCount/2-1));

% Filter for spatial doman. One can use either 'sheppLogan' or 'ramLak'
filterMode = 'ramLak';  

if mod(pCount,2) == 0
    halfFilSz = floor(1 + pCount);
else
    halfFilSz = floor(pCount);
end

% Proceed accourind to the input
if strcmp(filterMode,'ramLak')
    filter = zeros(1,halfFilSz);
    filter(1:2:halfFilSz) = -1./([1:2:halfFilSz].^2 * pi^2);
    filter = [fliplr(filter) 1/4 filter];
elseif strcmp(filterMode,'sheppLogan')
    filter = -2./(pi^2 * (4 * (-halfFilSz:halfFilSz).^2 - 1) );
end

% Loop 
figure
for i = 1:aCount
    rotCoords = round(midFBP + xFBP*sin(thetas(i)) + yFBP*cos(thetas(i)));

    % Check the boundedness
    indices   = find((rotCoords > 0) & (rotCoords <= pCount));
    newCoords = rotCoords(indices);
        
    % Setup new filter
    filteredProfile = conv(sinogram(:,i),filter,'same');
    filteredBP(indices) = filteredBP(indices) + filteredProfile(newCoords)./aCount;
    imagesc(filteredBP)
    drawnow

end

