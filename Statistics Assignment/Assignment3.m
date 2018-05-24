%% Clear all the variables
clear;
 
%% Read the csv file-
M=csvread('A3.csv');
format long
display([sort(M)])


%% Calculate the mean and variance of the sample

sampleMean=mean(M)
sampleVariance=var(M)
t=histogram(M);

