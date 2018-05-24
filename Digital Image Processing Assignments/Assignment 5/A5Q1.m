clear;
%%  The given matrix of the image
%img = [0 0 1 5 6; 0 0 1 5 6; 2 2 4 7 8; 3 3 7 4 2; 6 6 5 1 0];
img = imread('eight.tif');
img=double(img)
img = uint8(img);

% size
[row,col]=size(img);
% Copying
copyImg = img;
% Prediction
pred = copyImg;
% As given in the question, prediction using averaging
for i=2:row
    for j=2:col
        pred(i,j) = 0.5*(copyImg(i,j-1)+copyImg(i-1,j));
    end
end
% Error
error1 = copyImg - pred;

%% Discreatization of the error is as follows
b = 0.1;
t = 2;
for i=1:row
    for j=1:col
        if error1(i,j)<(-1)*t
            error1(i,j)=(-1)*b;
        elseif error1(i,j)<=t
            error1(i,j)=0;
        else
            error1(i,j)=b;
        end
    end
end
% Computing the weights using least mean square error method
% Considering 2 nearest neighbours only
A = zeros((row-1)*(col-1),2);
P = zeros((row-1)*(col-1),1);
q=1;
for i=2:row
    for j=2:col
        A(q,1)= copyImg(i-1,j);
        A(q,2)= copyImg(i,j-1);
        P(q,1) = copyImg(i,j);
        q=q+1;
    end
end

weight = pinv(A)*P;
A2 = A*weight;
F2=copyImg;


q=1;
for i=2:row
    for j=2:col
        F2(i,j)=A2(q,1);
        q=q+1;
    end
end
%% Error in this case
error2 = copyImg - F2;
for i=1:row
    for j=1:col
        if error2(i,j)<(-1)*t
            error2(i,j)=(-1)*b;
        elseif error2(i,j)<=t
            error2(i,j)=0;
        else
            error2(i,j)=b;
        end
    end
end

%% Considering 2 nearest neighbours
A3 = zeros((row-2)*(col-2),8);
P3 = zeros((row-2)*(col-2),1);
q=1;
for i=2:row-1
    for j=2:col-1
        A3(q,1)= copyImg(i-1,j-1);
        A3(q,2)= copyImg(i-1,j);
        A3(q,3)= copyImg(i-1,j+1);
        A3(q,4)= copyImg(i,j-1);
        A3(q,5)= copyImg(i,j+1);
        A3(q,6)= copyImg(i+1,j-1);
        A3(q,7)= copyImg(i+1,j);
        A3(q,8)= copyImg(i+1,j+1);
        P3(q,1) = copyImg(i,j);
        q=q+1;
    end
end
weight1 = pinv(A3)*P3;
G3 = A3*weight1;
F3=copyImg;
q=1;
for i=2:row-1
    for j=2:col-1
        F3(i,j)=G3(q,1);
        q=q+1;
    end
end
error3 = copyImg - F3;
for i=1:row
    for j=1:col
        if error3(i,j)<(-1)*t
            error3(i,j)=(-1)*b;
        elseif error3(i,j)<=t
            error3(i,j)=0;
        else
            error3(i,j)=b;
        end
    end
end
disp('Weight using 2 neighbours:');
weight
disp('Weight using 8 neighbours: ');
weight1

E1=0;
for(u=1:4)
    for( p=1:4)
        E1=E1+error1(u,p)^2;
        
    end
end

disp('Root Mean Square error with average approzimation');
E1=sqrt(E1)


E2=0;
for(u=1:4)
    for( p=1:4)
        E2=E2+error2(u,p)^2;
        
    end
end

disp('Root Mean Square error with 2 neighbour approximation');
E2=sqrt(E2)


E3=0;
for(u=1:4)
    for( p=1:4)
        E3=E3+error3(u,p)^2;
        
    end
end
disp('Root Mean Square error with 8 neighbour approzimation');
E3=sqrt(E3)

