function V= dividedDiff(X,Y,U)
[X;Y];
[xSorted, xorder]= sort(X);
ySorted=Y(xorder);
X=xSorted;
Y=ySorted;
[X;Y];




%Code written by-
% Alankar Meshram (2014MT60551)
% Exercise 8: Newton Divided difference



% X is the data-point matrix
% Y is the image matrix
% U vector contains points at the the value of function is to be found


% Check for proper dimensions of the input matrices
[a,b]=size(X);
[c,d]=size(Y);
if([a,b]~=[c,d]) %Show error if dimensions are not same
  error('Input matrix must have same dimensions');
end;

if(a~=1)        %check for row matrix
  error('Invalid input-please insert a row matrix');
end;

% newtonDiv will store the value of Newton's divided difference.
% Initialized with a b x b zero matrix
newtonDiv= zeros(b,b);
% first column consists of the the given image points only 
newtonDiv(:,1)=Y';
for j=2:b;

s= b-j+1; %to ensure the upper row of newtonDiv always contains the 
          %coefficients of the polynomial 
  for i=1:s     
  funDiff=newtonDiv(i+1,j-1)-newtonDiv(i,j-1); %numerator of the ith 
                                               %divided difference
  pointDiff=X(i+j-1)-X(i);  %denominator of the ith divided diff
  newtonDiv(i,j)= (funDiff/pointDiff); %divided diff computed and 
                                         %put in newtonDiv matrix
  end;
  
  
  
  newtonDiv;
  
  %The first row of newtonDiv contains the requried coeffients. These are
  %put in matrix C
  C=newtonDiv(1,:);
  
  %VAR b x 1 matrix initialized with ones
  VAR=ones(b,1);
  %V column initialized with ones
  V=zeros(length(U),1);
  
  % Iterating through all the unknown points where the value of the
  % function is to be found
  for point=1:length(U)
    for i=2:b
    VAR(i)=VAR(i-1)*(U(point)-X(i-1)); % Constructing the variable matrix
                                       % which will store the non-cofficent
                                       % part of the polynomial
    
    end;
    % Multiplying coefficients obtained by divided difference to the value
    % of non-coefficient part and summing up the result to get the value of
    % the function at that unknown point. The value of the funcion if
    % stored in matrix V
    V(point)=C*VAR;                   
                                        
  end;
  

 
  

  
  
  
end;


