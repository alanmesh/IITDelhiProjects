function [cost] = costFunction(estimateT,trueT)

 cost = (norm(estimateT-trueT))^2;
 end