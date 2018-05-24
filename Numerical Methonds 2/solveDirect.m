 function Tmeas = solveDirect(x,t,mLoc,sLoc,s)
 %Solve the direct problem with insulated boundaries.
 %Input: x (space vector), t (time vector), measurement location, source
 %location, source function
 %Output: temperature at each timestep evaluated at the measurement
 %location.

 hx = x(2) - x(1);
 ht = t(2) - t(1);
 Nx = length(x);

 TOld = zeros(Nx*Nx,1);

 %Construct second derivative matrix
 D = ht/hx^2*(diag(-2*ones(Nx,1)) + diag(ones(Nx-1,1),1) + diag(ones(Nx-1,1),-1));

 %Fix BCs
 D(1,1) = -ht/hx^2;
 D(1,2) = ht/hx^2;

 D(end,end) = -ht/hx^2;
 D(end,end-1) = ht/hx^2;
 D = kron(eye(Nx),D) + kron(D,eye(Nx));


 D = eye(size(D)) - D;
 D = sparse(D);
 %Vectors to hold result
 Tmeas = zeros(length(t),size(mLoc,1));
 sourceIndex = zeros(size(sLoc,1));
 measureIndex = zeros(size(mLoc,1));
 for i = 1:size(sLoc,1)
 sourceIndexX = find(abs(x-sLoc(i,1))<hx/10);
 sourceIndexY = find(abs(x-sLoc(i,2))<hx/10);
 sourceIndex(i) = MNtoI(sourceIndexX,sourceIndexY,Nx,Nx);
 end
 for i = 1:size(mLoc,1)
 measureIndexX = find(abs(x-mLoc(i,1)) < hx/10);
 measureIndexY = find(abs(x-mLoc(i,2))<hx/10);
 measureIndex(i) = MNtoI(measureIndexX,measureIndexY,Nx,Nx);
 end

 for k = 1:length(t)
 TNew = D\TOld;

 %Add source
 for i = 1:size(sLoc,1)
 TNew(sourceIndex(i)) = TNew(sourceIndex(i)) + ht*s(k,i);

 %Grab T at mLoc
 for i = 1:size(mLoc,1)
 Tmeas(k,i) = TNew(measureIndex(i));
 end

 %Update TOld
 TOld = TNew;
 end

 end