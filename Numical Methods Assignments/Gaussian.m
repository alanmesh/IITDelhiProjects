%Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 3: Gaussian Elimination
%The script takes the following inputs-

% The square matrix A
% Right hand side vector B




%  The code will take the aforementioned inputs and print the solution matrix x

A = input(['Enter the square matrix A: ']);
d=length(A);
detA=det(A);
% Check if A is invertible
if(detA==0)
disp('Input matrix not invertible')
return;
end


 b= input(['Enter matrix b: ' ]);
 [aa,bb]=size(b);
 if(aa~=d)
  disp('Enter column matrix of proper dimensions');
  return;
  end;
if(bb~=1)
  disp('Enter column matrix');
  return;
  end;
% itrating through the columns and then through the rows
for j=1:d
 for t=j+1:d
     
     % implemeting swapping if the diagonal element happens to be 0
     if(A(j,j)==0)
      rowTemp=A(j,:);
      rowTempb=b(j,:);
      rowToSwap=j+1;
      for(s=j+1:d)
        if(A(s,s)~=0)
          rowToSwap=s;
          break;
        end;
      end;
      
      A(j,:)=A(rowToSwap,:);
      A(rowToSwap,:)=rowTemp;
     % doing the same swapping in matrix b
      b(j,:)=b(rowToSwap,:);
      b(rowToSwap,:)=rowTempb;      
    
    end
 

    temp=A(t,j)/A(j,j);
    % doing the well-known gaussian elemination on the modified matrices
    A(t,:)=A(t,:)-temp*A(j,:);
    b(t)=b(t)-temp*b(j);
   
  end
end


x=ones(d,1);

i=d;

% implementing the back substitiution
while (i>0)
prod=0;
  for(j=i+1:d)
      % start from the last row
      prod=prod+A(i,j)*x(j);
  end
    % store the solution in x
    x(i)=(b(i)-prod)/A(i,i);
  i=i-1;
  end


A;
b;
x



