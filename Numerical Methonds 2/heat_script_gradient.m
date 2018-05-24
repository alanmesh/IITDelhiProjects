close all;
clc;
hx = 1e-1;
x = 0:hx:1;
tMax = 1;
ht = 1e-4;
t = 0:ht:tMax;
t = t(2:end);
mLoc = [0.2 0.2; 0.8 0.8; 0.2 0.8; 0.8 0.2];
sLoc = [0.5, 0.5];
TRUE_SOURCE =sin(5*t).^2;
TRUE_SOURCE = TRUE_SOURCE';
TRUE_TMEAS = solveDirect(x,t,mLoc,sLoc,TRUE_SOURCE);

sigma2 = mean(mean(TRUE_TMEAS))*0.001;
TRUE_TMEAS_BACKUP = TRUE_TMEAS;
TRUE_TMEAS = TRUE_TMEAS + sqrt(sigma2).*randn(size(TRUE_TMEAS));

% Initial guess.
f=(zeros(length(t),1));
tol = 1e-12;
alpha = 1e-6;
Dtol = 1e-3;
maxits=500;
oldc = 1e8;
for i = 1:maxits
    tempTemps = solveDirect(x,t,mLoc,sLoc,f);
    C = costFunction(tempTemps,TRUE_TMEAS);
    temp = abs(C-oldc)/oldc;
    if (C < tol)
        subplot(1,2,1);
        plot(TRUE_SOURCE);
        subplot(1,2,2);
        plot(f);
        break
    end
    lambda = solveAdjoint(x,t,mLoc,sLoc,tempTemps,TRUE_TMEAS)-alpha*[diff(f,2);0;0];
    grad = lambda;
    f = f - 1000*grad;
    oldc=C;
     P=['iteration=', num2str(i)];
    disp(P)
end
subplot(1,2,1);
plot(TRUE_SOURCE);
subplot(1,2,2);
plot(f);