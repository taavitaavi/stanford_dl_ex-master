
preds = round(signatureRecognitionNeuralNetworkFunction(testSet))

acc = sum(preds(1,:)==testLabels(1,:))/length(preds);
