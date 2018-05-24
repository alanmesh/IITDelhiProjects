%Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 7: Conjugate gradient method with preconditioner
% The script takes the following inputs-
%  
% The Square Matrix A
% Right hand side vector B
% Pre-conditoner matrix M
% initial guess x
% The code will take the aforementioned inputs and print the solution matrix x


% Get the matrices A,b,M and x from the user 
A = input(['Enter matrix A: ']);

% Check from square matrix
[nn,mm]=size(A);
if(mm~=nn)
error('Please enter a square matrix');
return
end;

if(~issymmetric(A))     %checks for symmetry
disp('Input matrix not symmetric')
return
end


%evaluate the eigen vales of A. If any eigenvalue is not postive, then
%display matrix is not positive definite
eigValuesOfA = eig(A);

for i = 1:rank(A)
	if (eigValuesOfA(i) <= 0)
	Error(['the matrix is not positive definite'])
  return
	end
end



b=input(['Input matrix b: ']);


% Check for proper dimension of b. B should be column vector of same length as
% A
[aa,bb]=size(b);

if(aa~=nn)
    error('b is not of the proper dimension')
    return
end;
if(bb~=1)
    error('b is not a column vector')
    return
end;
% Check for valid dimension of M
M=input(['Input matrix M: ']);
if(size(M)~=[nn,mm])
    error('M is not of the same dimensions as A.')
    return
end;
% Check from symmetric matrix

if(~issymmetric(A))   
disp('Input matrix not symmetric')
return
end
% Check for positive definite
eigValuesOfM = eig(M);

for i = 1:rank(M)
	if (eigValuesOfM(i) <= 0)
	Error(['the matrix is not positive definite'])
  return
	end
end



% Check for valid dimensions of x
x = input(['Enter initial guess: ']);
  [gg,ll]=size(x);
if(gg~=nn)
    error('x is not of the proper dimension')
    return
end;
if(ll~=1)
    error('x is not a column vector')
    return
end;



% implementing the preconditioned conjugate gradient method
  
  r=b-A*x;
  z=inv(M)*r;
  p=z;
  rNext=1; % value just to start the loop
  v=0;     
 
 
  % iterate till length of b times or till r is sufficiently small
  while((sqrt(rNext)<1e-10)||(v<length(b)))
   v=v+1;
   
   % compute aplha
   aplh=(r'*z)/(p'*A*p);
  
   % next iteration
   xNext= x+aplh*p;
   rNext= r-aplh*A*p ;
    
   zNext=inv(M)*rNext;
   bet=zNext'*rNext/(z'*r);
   r=rNext;
   p=zNext+bet*p;
   z=zNext;
   x=xNext;
   
  end
  
  
   % final answer
   x
              

  




