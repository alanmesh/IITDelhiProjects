%Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 4: LU Decomposition
% The script takes the following input-
% Square Martix M whose LU decomposition is to found




%  The code will take the aforementioned inputs and print the permutation 
%  matrix P,lower triabgle matrix L and upper triangle matrix U

clear;  % Clear all the exiting variables
x = input(['Enter the square matrix: ']);
d=size(x); %dimension of square matrix
detX=det(x)

%Condition for checking inverse
if(detX==0)
disp('Input matrix not invertible')
return;

else 
disp('Input matrix is invertible')
end

L=eye(d);   % initialize L as identity matrix of dimension d
P=eye(d);   % same with P
U=x;        % initialize U with x



for j=1:d
  pivot=0;  %Stores the value of the element at pivot position
  pivotPosition=-1; 
  for i=j:d
 
  
      if(abs(U(i,j))>abs(pivot)) % Finding max element of columns and 
                                 % Setting value of pivot & pivotPosition
      pivot=U(i,j);                
      pivotPosition=i;
    end
   end
  
  if(pivotPosition~=j)
     % Swaping if the maximum element of a column is not the diagonal
     temp=U(j,:);
     U(j,:)=U(pivotPosition,:);
     U(pivotPosition,:)=temp;
       
     % Doing the same swapping with P 
     temp=P(j,:);
     P(j,:)=P(pivotPosition,:);
     P(pivotPosition,:)=temp;
     
     % Same swapping with L
     temp=L(j,1:j-1);
      L(j,1:j-1)=L(pivotPosition,1:j-1);
     L(pivotPosition,1:j-1)=temp;
     
     
     
  end
    
  for t=j+1:d
      
     % Modifying L and U to make them lower and upper triangular matrix
     % respectively.
    L(t,j)=U(t,j)/U(j,j);
    U(t,:)=U(t,:)-L(t,j)*U(j,:);
   
  end
  end
U
L
P













