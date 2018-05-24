function [] = A1Q3(image_path,zY,zX,angle,method)
%% Zooming and shrinking an image using the bicubic/bilinear interpolation
% The script takes the follwing inputs-  
% image = input image to operate on. By default using inbuilt eight.tif
% zX for zoom along X
% zY for zoom along Y
% angle= Rotation in degrees of the image in the clockwise direction
% 
% Note- 
% To shrink the image, specify the zY or zY accordingly, 
% eg. to shrink the image by 1.7 along Y, set zY as 1/1.7
% Input method = 1 for bilenear and method = 2 for bicubic interpolation


%% Comman code for both the methods
image=imread(image_path);
[row ,col, dimension] = size(image);
rowFactored = floor(zY*row);
columnFactored = floor(zX*col);



%% Code for bilenear interpolation
if(method==1)
    imageZoom = zeros(rowFactored,columnFactored,dimension);
for i = 1:rowFactored;
    x1 = cast(floor(i/zY),'uint32');
    x2 = cast(ceil(i/zY),'uint32');
    if(x1 == 0)
        x1=1;
    end
    x = rem(i/zY,1);
    for j = 1:columnFactored;
        y1 = cast(floor(j/zX),'uint32');
        y2 = cast(ceil(j/zX),'uint32');
        if y1 == 0
            y1 = 1;
        end
        dim1 = image(x1,y1,:);
        dim2 = image(x2,y1,:);
        c1 = image(x1,y2,:);
        c2 = image(x2,y2,:);
        y = rem(j/zX,1);
        tNew = (c1*y)+(dim1*(1-y));
        bNew = (c2*y)+(dim2*(1-y));
        imageZoom(i,j,:) = (bNew*x)+(tNew*(1-x));
    end
end
zoomedImage = cast(imageZoom,'uint8');
image_zoom_rotate = imrotate(zoomedImage,angle,'bilinear');
end

%% code for bicubic interpolation
if (method==2)

imageZoom = cast(zeros(rowFactored,columnFactored,dimension),'uint8');
imagePad = zeros(row+4,col+4,dimension);
imagePad(2:row+1,2:col+1,:) = image;
imagePad = cast(imagePad,'double');
for m = 1:rowFactored
    x1 = ceil(m/zY); x2 = x1+1; x3 = x2+1;
    p = cast(x1,'uint16');
    if(zY>1)
       s1 = ceil(zY*(x1-1));
       s2 = ceil(zY*(x1));
       s3 = ceil(zY*(x2));
       s4 = ceil(zY*(x3));
    else
       s1 = (zY*(x1-1));
       s2 = (zY*(x1));
       s3 = (zY*(x2));
       s4 = (zY*(x3));
    end
%% Performing the cubic interpolation now
    X = [ (m-s2)*(m-s3)*(m-s4)/((s1-s2)*(s1-s3)*(s1-s4)) ...
          (m-s1)*(m-s3)*(m-s4)/((s2-s1)*(s2-s3)*(s2-s4)) ...
          (m-s1)*(m-s2)*(m-s4)/((s3-s1)*(s3-s2)*(s3-s4)) ...
          (m-s1)*(m-s2)*(m-s3)/((s4-s1)*(s4-s2)*(s4-s3))];
    
for n = 1:columnFactored
        y1 = ceil(n/zX); y2 = y1+1; y3 = y2+1;
        if (zX>1)
           p1 = ceil(zX*(y1-1));
           p2 = ceil(zX*(y1));
           p3 = ceil(zX*(y2));
           p4 = ceil(zX*(y3));
        else
           p1 = (zX*(y1-1));
           p2 = (zX*(y1));
           p3 = (zX*(y2));
           p4 = (zX*(y3));
        end
        Y = [ (n-p2)*(n-p3)*(n-p4)/((p1-p2)*(p1-p3)*(p1-p4));...
              (n-p1)*(n-p3)*(n-p4)/((p2-p1)*(p2-p3)*(p2-p4));...
              (n-p1)*(n-p2)*(n-p4)/((p3-p1)*(p3-p2)*(p3-p4));...
              (n-p1)*(n-p2)*(n-p3)/((p4-p1)*(p4-p2)*(p4-p3))];
        qNew = cast(y1,'uint16');
        sample = imagePad(p:p+3,qNew:qNew+3,:);
        imageZoom(m,n,1) = X*sample(:,:,1)*Y;
        if(dimension~=1)
              imageZoom(m,n,2) = X*sample(:,:,2)*Y;
              imageZoom(m,n,3) = X*sample(:,:,3)*Y;
        end
    end
end
imageZoom = cast(imageZoom,'uint8');
image_zoom_rotate = imrotate(imageZoom,angle,'bicubic');
end;

%% Displaying the final images
figure 
imshow(image);
figure
imshow(image_zoom_rotate);

    
    
    
        
        




















end

