function [ I ] = MNtoI(m,n,M,N)
%Converts row, column to linear indexing
I=(n-1)*M+m;
end