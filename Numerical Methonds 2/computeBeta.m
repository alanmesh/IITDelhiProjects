 function beta = computeBeta (Tmeas,TRUE_TMEAS,DT)
 beta = (Tmeas - TRUE_TMEAS)'*DT / (DT'*DT);
 end