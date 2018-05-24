%Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 1: Newton's Method
%The script takes the following inputs-
% initial guess: x
% function: f
% derivative of f: df



%  The code will take the aforementioned inputs and ptints all the iterations on
%  the screen, tells whether the metod coverges or not and prints the computed
%  root. 


x=10;                    %initial guess
dx=5;                   %value to start up the loop
f=@(x) (x-3)^3;       %input funtion  
if(f(x)==0)
    disp('Initial guess is root itself')
    return;
end
df=@(x) 3*((x-3)^2);          %derivative of the function
count=1;                %iterations
tol=0.000001;           %tolerance
minStepLength=0.000001; %minimum step length

%Code to print the iterations
fprintf('--------------------------------\n')
fprintf('step        x        dx         f(x)\n')
fprintf('---------------------------------\n')
fprintf('%3i %12.8f %12.8f %12.8f\n',count,x,dx,f(x))

G=zeros(2,1); %G matrix to store the value of function after each iteration
while(dx>minStepLength)
if(df(x)==0)
    disp('Non- convergent method')
    return
end
xNext= x-(f(x)/df(x));  %xNext is the updated value of the variable


dx=abs(x-xNext);     %Step length in current iteration

fLast=f(x);

G(count)=fLast;             
x=xNext;        
f(x); 

count=count+1;  %updating loop variable
if(count>510)
disp('Maximum iterations reached')
break;
end
fprintf('%3i %12.8f %12.8f %12.8f\n',count,x,dx,f(x))

end


length(G);
figure;
hold on
for ii = 1:length(G)
 plot(G(:))
end
