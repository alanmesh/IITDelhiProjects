function V= pieceWise(X,Y,U)
[X;Y];
[xSorted, xorder]= sort(X);
ySorted=Y(xorder);
X=xSorted;
Y=ySorted;
[X;Y];

%Code written by-
% Alankar Meshram (2014MT60551)
% Exercise 9: Piecewise linear interpolation method



% X is the data-point matrix
% Y is the image matrix
% U vector contains points at the the value of function is to be found


% Code to check the dimensions of the input matrix. Throws error if
% dimensions of the matix are incorrent.
[a,b]=size(X);
[c,d]=size(Y);
if([a,b]~=[c,d]) %check for same dimensions
  error('Input matrix must have same dimensions');
end;

if(a~=1)          %check for row vector
  error('Invalid input- Please pass a row marix as input');
end;


  

%Initialize V as a column vector with all the zeroes. 
V=zeros(length(U),1);

for i=1:length(U) %iterate through all the points where value of function
                  %is to be found
  point=U(i);       
  j=0;
  temp=1;
  
  %Find the nearest point to the unknown point 
  while temp<b+1
    if(point<X(temp))
      j=temp;
      break;
    end;
    temp=temp+1;
  end;
  
  %find the value of the function at the unknown points using linear
  %interpolation. The values are put in the output matrix V
  %constructing linear interpolation dynamically
  V(i)=Y(j-1)+(((point-X(j-1))*(Y(j)-Y(j-1)))/(X(j)-X(j-1)));
end;
  
  
  