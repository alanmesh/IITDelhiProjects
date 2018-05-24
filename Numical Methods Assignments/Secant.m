%Code written by-
% Alankar Meshram (2014MT60551)
% Assignment 2: Secant Method
%The script takes the following inputs-
% initial guess: x1 and x2
% function: f




%  The code will take the aforementioned inputs and ptints all the iterations on
%  the screen, tells whether the metod coverges or not and prints the computed
%  root. 

% funtion= sin(x)-cos(x)

x0=pi/3;             %first guess
x1=4;             %second guess
dx=5;             %value to start up the loop
f=@(x) sin(x) ; %function 
if(abs(f(x0))<=0.00000001)
    fprintf('   f takes the value 0 at %6.8f \n',x0)
    return;
end
if(abs(f(x1))<=0.00000001)
    fprintf('   f takes the value 0 at %6.8f\n',x1)
    return;
end



if(f(x1)==f(x0))
disp('The value of function is same at both the points. Secant method not applicable.');
return
end
count=1;        %iterations
tol=0.000001;   %tolerance
minStepLength=0.000001; %minimum step length


%Code to print iterations
fprintf('--------------------------------\n')
fprintf('step        x        dx         f(x)\n')
fprintf('---------------------------------\n')
fprintf('%3i %12.8f %12.8f %12.8f\n',count,x1,dx,f(x1))

while(dx>minStepLength||abs(f(x1))>tol)
 
df=(f(x1)-f(x0))/(x1-x0);   %df is the approximate derivative
if(df==0)
disp('Non-convergent method')
return
end
xNext=x1- f(x1)/df;           %finding the next value of the variable

dx=abs(x1-xNext);           %step length
if(count>5)
if(abs(f(xNext))-abs(f(x1))>0)
    disp('Non convergent method')
    return
end;
end;

x0=x1;                      %updating variable
x1=xNext;


count=count+1;
if(count>1000)
disp('Maximum iterations reached.')
return
end
fprintf('%3i %12.8f %12.8f %12.8f\n',count,x1,dx,f(x1))


end;
if (abs(f(xNext))<=tol)
 fprintf('Convergennt method. \n ')
 end





