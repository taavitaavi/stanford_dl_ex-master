accuracies=[]
net = patternnet(30);
for i=1:25
[ trainingSet,trainingLabels,testSet,testLabels ] = div2TrainingAndTestSet( dataSet,dataSetLabels,0.7 );
net = train(net,trainingSet,trainingLabels);
preds= round(net(testSet));
acc = sum(preds(1,:)==testLabels(1,:))/length(preds);
accuracies(i)=acc;
end
disp(['average accuracy: ' num2str(mean(accuracies))])
