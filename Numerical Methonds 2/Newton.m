%We assume initial condition is all 0, and BCs are insulated (Neumann, 0
%derivative).
close all;
clc;

%X domain is [0,1], step size is hx
hx = 1e-1;
x = 0:hx:1;

%t domain is (0,tMax], step size is ht
tMax = 1;
ht = 1e-4;
t = 0:ht:tMax;
t = t(2:end);


%Measurements are taken at mLoc, point source is at sLoc
mLoc = [0.2 0.2; 0.8 0.8; 0.2 0.8; 0.8 0.2];
sLoc = [0.5, 0.5];

%Need to give a source function and take measurements
%(construct true solution)
TRUE_SOURCE =sin(5*t).^2;
TRUE_SOURCE = TRUE_SOURCE';
TRUE_TMEAS = solveDirect(x,t,mLoc,sLoc,TRUE_SOURCE);

%Add noise
sigma2 = mean(mean(TRUE_TMEAS))*0.001;
TRUE_TMEAS_BACKUP = TRUE_TMEAS;
TRUE_TMEAS = TRUE_TMEAS + sqrt(sigma2).*randn(size(TRUE_TMEAS));


%Regularization parameter
alpha = 1e-6;

%First we need an initial guess for the source, which is located at sLoc.
s=(zeros(length(t),1));

%Define  alloable tolerance,delta tolerance, and max number of iterations
tol = 1e-12;
deltaTolerance = 1e-3;
maxits=500;
oldCost = 1e8;

%Solve direct problem to get T
for i = 1:maxits
    expTemps = solveDirect(x,t,mLoc,sLoc,s);
    C = costFunction(expTemps,TRUE_TMEAS);
    curTolerance = abs(C-oldCost)/oldCost;
   
     
    if (C <= tol)
        subplot(1,2,1);
        plot(TRUE_SOURCE);
        subplot(1,2,2);
        plot(s);
        break
    end
   
    lambda = solveAdjoint(x,t,mLoc,sLoc,expTemps,TRUE_TMEAS)-alpha*[diff(s,2);0;0];
    grad = lambda;
    s = s - 1000*grad;
    oldCost=C;
    P=['iteration=', num2str(i)];
    disp(P)
   
    
end
subplot(1,2,1);
plot(TRUE_SOURCE);
subplot(1,2,2);
plot(s);