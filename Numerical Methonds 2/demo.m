%Copy-paste code here to remove the line numbers.
 %We assume initial condition is all 0, and BCs are insulated (Neumann, 0
 %derivative).
 clear all;
 close all;
 clc;

 %X domain is [0,1], step size is hx
 hx = 1e-1;
 x = 0:hx:1;

 %t domain is (0,tMax], step size is ht
 tMax = 1;
 ht = 1e-3;
 t = 0:ht:tMax;
 t = t(2:end);

 %Measurements are taken at mLoc, point source is at sLoc
 mLoc = [0.2 0.2; 0.8 0.8; 0.2 0.8; 0.8 0.2];
 %mLoc = [0.8 0.8];
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

 %%
 %Regularization parameter
 alpha = 1e-3;
 %alpha = 0.25;
 %First we need an initial guess for the source, which is located at sLoc.
 s = zeros(length(t),1);
 gradSOld = solveAdjoint(x,t,mLoc,sLoc,zeros(length(t),size(mLoc,1)),TRUE_TMEAS); 
 d = 0;
 tol = 1e-12;
 maxits = 200;
 oldcost = 1e8;
 Dtol = 1e-3;
 costMat=zeros(maxits,1);
 betaMat=zeros(maxits,1);
 %%
 for i = 1:maxits
     disp(i)
 %Solve direct problem −−> get T
 Tmeas = solveDirect(x,t,mLoc,sLoc,s);

 %Check cost
 cost = costFunction(Tmeas,TRUE_TMEAS);
 costMat(i,1)=cost;
 if (cost < tol || abs(cost - oldcost)/oldcost < Dtol)
 break
 end

 %Solve adjoint problem given T at the measurement location(s)
 %and the measured data −−> get lambda

 lambda = solveAdjoint(x,t,mLoc,sLoc,Tmeas,TRUE_TMEAS);

 %With lambda, compute grad(S)
 gradS = lambda - alpha*[diff(s,2);0;0];

 %With grad(S), compute gamma (how much weight on old direction) and new
 %direction
 gamma = computeGamma(gradS,gradSOld,i);
 d = gradS + gamma*d;

 %Solve sensitivity problem in this new direction
 DT = solveSensitivity(x,t,mLoc,sLoc,d);

 %compute step size beta
 betaCoeff = computeBeta(Tmeas(:),TRUE_TMEAS(:),DT(:));
 betaMat(i,1)=betaCoeff;

 %compute new source guess, repeat
 s = s - betaCoeff*d;
 gradSOld = gradS;
 oldcost = cost;
 
 end
 % figure;
 %plot(t,s,'-b', 'LineWidth', 2);
 %figure;
 %plot(1:i, costMat(1:i), '-b', 'LineWidth', 2);
 %figure;
 %plot(1:i, betaMat(1:i), '-b', 'LineWidth', 2);
 %%
