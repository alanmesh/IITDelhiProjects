 function gamma = computeGamma(gradS,gradSOld,k)
 gamma = 0;
 if k == 1
 return
 end
 gamma = gradS'*(gradS - gradSOld) / (gradSOld'*gradSOld);
 end