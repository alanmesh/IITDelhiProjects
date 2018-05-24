im=imread('newimg.png') ;
newImg = rgb2gray(im); % Convert to grayscale
%% Code to use the CHT function-
 newFilter = [1 1 1 1 1; 1 2 2 2 1; 1 2 4 2 1; 1 2 2 2 1; 1 1 1 1 1];
 newFilter = newFilter / sum(newFilter(:));
 imgfltrd = filter2( newFilter , newImg );
 tic;
 
 [a, enCircle, radius] = CHT(imgfltrd, [15 58], 35, 25);
 toc;
Circles=0;
 figure(1); imagesc(newImg); colormap('gray'); axis image;
 hold on;
 plot(enCircle(:,1), enCircle(:,2), 'r+');
 for k = 1 : size(enCircle, 1),
     DrawCircle(enCircle(k,1), enCircle(k,2), radius(k), 32, 'b-');
    Circles=Circles+1;
 end
 hold off;
 title(['Number of Circles= ' int2str(Circles)]);
%% Code to carry out the color filtering
imtool(im);
sz=size(im);
newIM=im;
for i=1:sz(1)
    for j=1:sz(2)
        if (im(i,j,1)>30&&im(i,j,1)<180 && im(i,j,2)>30&&im(i,j,2)<180 && im(i,j,3)>30 &&im(i,j,3)<180)
        else
            newIM(i,j,1)=0;
            
            newIM(i,j,3)=0;
            newIM(i,j,2)=0;
            
        end
    end
end

imtool(newIM);