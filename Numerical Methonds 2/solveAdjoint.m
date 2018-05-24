 function lambda = solveAdjoint(x,t,mLoc,sLoc,estimateT,trueT)
 %This needs to be a change−of−variables on the direct equation
 force = 2*(estimateT-trueT);
 force = flipud(force);
 %disp(sprintf('cvbnm'));
 lambda = solveDirect(x,t,sLoc,mLoc,force);
 %disp(sprintf('cvbnvbnm'));
 lambda = flipud(lambda);
 end