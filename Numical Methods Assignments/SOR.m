% Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 6: SOR
% The script takes the following inputs-
% coefficient matirix A, constant matrix B and an initial guess X


%Code to get input from the user:

A = input(['Enter the coefficient Matrix A: ']);
[m,n]=size(A);
%Throw error if the matrix is NOT a square matrix
if(m~=n)
  error(['Please enter a square matrix']);
end;
%Check for column vectors X and B
B = input(['Enter the constant Matrix B: ']);
if(size(B)~=[m,1]);
  error(['Invalid Input B.'])
end;
X = input(['Enter the initial guess X: ']);

if(size(X)~=[m,1]);
  error(['Invalid Input X[].'])
end;

w=1.5; %Relaxation factor;

%splitting the matrix A into Upper Lower and Diagonal matrix;

temp=diag(A);
D=diag(temp);
L=tril(A-D);
U=triu(A-D);


% Rewrite the system of linear equations as:
% (D+w*L)x=w*B-(w*U-(w-1)*D)*x
% Undet the new System, define matrix iterative matrix S as:
S=inv(D+w*L)*(D*(1-w)- w*U);

%evaluating the maximum eigen value of the matrix S
maxE=abs(max(eig(S)));
if(maxE>=1)
  %Display error message and exit gracefuly
  disp(['The absolute maximum value of S is more than 1'])
  disp(['The system in divergent for the SOR method.']);
  return;
end;
 
  
% function to compte the next iteration of the new system  
%f=@(X)(inv(D+w*L))*(((1-w)*D-w*U)*X +w*B);

%tolerance  
tol=0.0000001;
% error set to max to always execute the loop always once
err=inf;
count=1;
xNext=(inv(D+w*L))*(((1-w)*D-w*U)*X +w*B);
abs(X-xNext);
while (abs(max(X-xNext))>tol)

  % Find the next iteration of X and store it in xNext
  X=xNext;     %Update the variable 
  xNext=(inv(D+w*L))*(((1-w)*D-w*U)*xNext +w*B);
  
  
  count=count+1;
  if(count>1000)
      disp('1000 iteration reached.')
      disp('Solution not found till now under the given tolerance')
      return;
  end;
  
end;
X
count;

  








