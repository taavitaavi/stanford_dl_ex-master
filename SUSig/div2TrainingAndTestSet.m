function [ trainingSet,trainingLabels,testSet,testLabels ] = div2TrainingAndTestSet( dataSet,dataSetLabels,percentageOfDataInTrainingset )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

num_points = size(dataSet,2);
split_point = round(num_points*percentageOfDataInTrainingset);
seq = randperm(num_points);
trainingSet = dataSet(:,seq(1:split_point));
trainingLabels = dataSetLabels(:,seq(1:split_point));
testSet = dataSet(:,seq(split_point+1:end));
testLabels = dataSetLabels(:,seq(split_point+1:end));


end

