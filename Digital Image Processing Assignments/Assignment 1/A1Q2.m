%% The folling program reads the image into I and performed the requiite transfrom;


%% Read the image
I = imread('eight.tif');


%% Perform first operation
firstTransformMatrix = [3 0 0;0 2 0;0  0 1];
firstTransform = maketform('affine', firstTransformMatrix);
firstImage = imtransform(I, firstTransform);

%% Perform second operatiom
secondTransformMatrix = [1 0 0;0 1 0;6 7 1];
secondTransform = maketform('affine', secondTransformMatrix);
tempSecond=imtransform(firstImage, secondTransform);
secondImage = imtranslate(tempSecond,[6, 7]);

%% Perform third operation
angle = (-1)*75/180*(pi);
thirdTransformMatrix = [cos(angle) sin(angle) 0; (-1)*sin(angle) cos(angle) 0; 0 0 1 ];
thirdTransform = maketform('affine', thirdTransformMatrix);
thirdImage = imtransform(secondImage, thirdTransform);

%% Plot the result
figure
subplot(2,2,1), imshow(I), title('Original Image');
subplot(2,2,2); imshow(firstImage), title('First Operation');
subplot(2,2,3); imshow(secondImage), title('Second Operation');
subplot(2,2,4);imshow(thirdImage), title('Third Operation');
