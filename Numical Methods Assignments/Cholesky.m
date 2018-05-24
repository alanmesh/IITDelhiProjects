%Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 4: LLt Decomposition
%The script takes the following inputs-
% The square matrix x





%  The code will take the aforementioned inputs and print the lower
%  triangular matrix L

%Code to get input from the user:

x = input(['Enter square matrix: ']);
d= length(x);


if(~issymmetric(x))     %checks for symmetry
disp('Input matrix not symmetric')
return
end


%evaluate the eigen vales of X. If any eigenvalue is not postive, then
%the matrix is not positive definite
eigValuesOfX = eig(x);

for i = 1:rank(x)
	if (eigValuesOfX(i) <= 0)
	disp('the matrix is not positive definite')
  return
	end
end

disp('the matrix is positive definite')

L=zeros(d,d);   % d x d matrix initialized with zeroes 

%Inserting values into L using Cholesky algorithm
for i=1:d
L(i,i)=sqrt(x(i,i)-L(i,:)*L(i,:)');
  for j=(i+1):d
  L(j,i)=(x(j,i)-L(i,:)*L(j,:)')/L(i, i);
  end
end

   
L
