% Create trainingset
startingfolder='C:\Users\taavi\Dropbox\kool2\kool\2015sygis\deep learning\SUSig\VisualSubCorpus\';
[ fullFileNames ] = getfullFilenames( startingfolder );
ShowSig=0;
folder='C:\Users\taavi\Dropbox\kool2\kool\2015sygis\deep_learning\SUSig\images\';
trainingSet=[];
trainingSetLabels=[];
trainingSetCounter=0;
testSet=[];
testSetLabels=[]
testSetCounter=0;
dataSet=[];
dataSetLabels=[];
dataSetCounter=0;
for i=1:length(fullFileNames)
    disp(['image ' int2str(i)]);
    FileName=fullFileNames{i};

    [X Y TStamp Pressure EndPts]=ReadSignature(FileName,ShowSig);
    n=100;
    k=find(EndPts);
    EndPts_res=ones(n,1);
    EndPts_res(round(n*k/length(EndPts))+1)=0;
    if(length(EndPts_res)>100)
        EndPts_res=EndPts_res(1:n);
    end
    Pressure_res=resample(Pressure,n,length(Pressure));
    x_res=resample(X,n,length(X));
%     norm_X = round((x_res - min(x_res)) / ( max(x_res) - min(x_res) )*n);
    y_res=resample(Y,n,length(Y));
%     norm_Y = round((y_res - min(y_res)) / ( max(y_res) - min(y_res) )*n);
%     norm_X(norm_X==0)=1;
%     norm_Y(norm_Y==0)=1;
%     norm_Pressure=round((Pressure_res - min(Pressure_res)) / ( max(Pressure_res) - min(Pressure_res) )*255);
        
    m=[x_res;y_res;Pressure_res;EndPts_res];
        splitPath=strsplit(FileName,'\');
%     dataSet(:,:,i)=m;
    userID=strsplit(char(splitPath(end)),'_');
    dataSet(:,i)=m;
    if (strcmp(userID(2),'f'))
%         dataSetCounter=dataSetCounter+1;
        dataSetLabels(size(dataSetLabels)+1)=2;
    else
        dataSetLabels(size(dataSetLabels)+1)=1;
    end
    
%     m=zeros(n);
%     
%     for j=2:length(norm_X)
%         m(norm_Y(j),norm_X(j))=norm_Pressure(j)*EndPts_res(j);
%         if(norm_Pressure(j-1)*EndPts_res(j-1)>0)
%             m=func_Drawline(m, norm_Y(j-1), norm_X(j-1), norm_Y(j), norm_X(j), norm_Pressure(j));
%         end
%     end
%     m=m(:,1:n);    

%     if(strcmp(splitPath{end-2},'VALIDATION'))
%         testSetCounter=testSetCounter+1;
%         testSet(:,:,testSetCounter)=m;
%         if(strcmp(splitPath{end-1},'VALIDATION_GENUINE'))
%             testSetLabels(end+1)=1;
%         else
%             testSetLabels(end+1)=0;
%         end
%     else
%         trainingSetCounter=trainingSetCounter+1;
%         trainingSet(:,:,trainingSetCounter)=m;
%         if(strcmp(splitPath{end-1},'FORGERY'))
%             trainingSetLabels(end+1)=0;
%             
%         else
%             trainingSetLabels(end+1)=1;
%         end
        
    clear memory
      
    end
% [C,~,ib] = unique(dataSetLabels);  
% dataSetLabels=ib;
labels=[]
for i=1:length(dataSetLabels)
    labels(dataSetLabels(i),i)=1;
end
dataSetLabels=labels;
percentageOfDataInTrainingset=0.8;
num_points = size(dataSet,2);
split_point = round(num_points*percentageOfDataInTrainingset);
seq = randperm(num_points);
trainingSet = dataSet(:,seq(1:split_point));
trainingLabels = dataSetLabels(:,seq(1:split_point));
testSet = dataSet(:,seq(split_point+1:end));
testLabels = dataSetLabels(:,seq(split_point+1:end));

    
%  saveas(trainingSet,'trainingSet','mmat')   

    
% end



