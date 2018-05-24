function V= naturalCubic(X,Y,J)
[X;Y];
[xSorted, xorder]= sort(X);
ySorted=Y(xorder);
X=xSorted;
Y=ySorted;
[X;Y];

% Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 10: Natural Cubic Spline Ineterpolation
% The script takes the following inputs-
% 
% X is the data-point matrix
% Y is the image matrix
% U vector contains points at the the value of function is to be found

% Check for proper dimensions of the input matrix X Y and J
  [a,b]=size(X);
  [c,d]=size(Y);
  if([a,b]~=[c,d])
    error('Input matrix must have same dimensions');
  end;

  if(a~=1)
    error('Invalid input');
  end;
  X=X'; %Transpose into column matrix
  
  Y=Y'; %Transpose into column matrix
 
  % We intend to create a system UZ=C system where U is the trigonal
  % matrix. Z is the matrix satisfying zi=S''(xi) 
  
  
  % We define the following matrices for the computation of the system.
  H=X(2:b)-X(1:b-1) ;   %Lower and upper diagonal entry of the trigonal matrix
  B=(Y(2:b)-Y(1:b-1))./H;
  
  S=2*(H(1:end-1)+H(2:end)); % Main Diagonal Entry
  U=6*(B(2:end)-B(1:end-1)) ; 
  
  
  
  
  high=H(1:end-1); %Upper diagonal entry
  low=H(2:end);    %Lower diagonal entry
  
  % Construct Matrix containing all the three diagonal  entries in its 
  % columns
                  
  Q=[low S high]; 
  
  % Construct the square matrix C having having a dimension of b-2 where b
  % is the number of input points (dimension of X). Using spdiags function
  % to create the trigonal matrix. [-1 0 1] is used as a parameter to
  % specify the three diagonals: upper, main and lower.
  
  
  C=full(spdiags(Q,[-1 0 1],b-2,b-2))';
  U;
  
  % Solve the System using inbuilt matlab \ operator
  
  Z=C\U;
  % Append 0 at the start and end of Z because in a natural cubic spline,
  % the double derivate of the polynomial at the extreme points of the
  % given sample is 0
Z=[0;Z;0];

  % Compute the matrices s0, s1, s2, s3 which are defined as
  % s0 contains the constant term of all the n-1 cubic polynomials  
  % s1 contains the coefficient of (q- X(i)) of the n-1 cubic polynomials
  % s2 contains the coefficient of (q- X(i))^2 of the n-1 cubic polynomials
  % s3 contains the coefficient of (q- X(i))^3 of the n-1 cubic polynomials

  s3=(Z(2:end)-Z(1:end-1))./(6*H);

  s2=Z/2;

  s1=B-H.*(2*Z(1:end-1)+Z(2:end))/6;
    
  s0=Y;

  % General qubic polynomial is implemented via function f which takes two
  % parameters: q and i. q is the value at which the value of the cubic
  % polynomial is to be found. i refers to the index of the element of j
  % just smaller than q. 
f = @(q,i) s0(i) + s1(i)*(q-X(i)) + s2(i)*(q-X(i))^2 + s3(i)*(q-X(i))^3;


for (p=1:length(J))  %iterate through all the points
  
  newPoint=J(p);    % store the current point in newPoint
  
  
  % search for nearest element in the input matrix to determine the index
  for(h=1:length(X))
  
    if(newPoint<=X(h))
      
      break;
    end;
  end;
 h=h-1; % Requried index
 %Compute the function at the unknown point newPoint
 V(p)=f(newPoint,h); 
    


end;
[J' V']


  
  
  


