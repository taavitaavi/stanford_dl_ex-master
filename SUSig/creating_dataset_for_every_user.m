% Create trainingset
startingfolder='C:\Users\taavi\Dropbox\kool2\kool\2015sygis\deep learning\SUSig\VisualSubCorpus\';
[ fullFileNames ] = getfullFilenames( startingfolder );
ShowSig=0;
folder='C:\Users\taavi\Dropbox\kool2\kool\2015sygis\deep_learning\SUSig\images\';
trainingSet=[];
trainingSetLabels={};
trainingSetCounter=0;
testSet=[];
testSetLabels={};
testSetCounter=0;
users={};
dataSet=[];
dataSetLabels={};

for i=1:length(fullFileNames)
    disp(['image ' int2str(i)]);
    FileName=fullFileNames{i};

    [X Y TStamp Pressure EndPts]=ReadSignature(FileName,ShowSig);
    n=100;
    k=find(EndPts);
    EndPts_res=ones(n,1);
    EndPts_res(round(n*k/length(EndPts))+1)=0;
    Pressure_res=resample(Pressure,n,length(Pressure));
    x_res=resample(X,n,length(X));
    norm_X = round((x_res - min(x_res)) / ( max(x_res) - min(x_res) )*n);
    y_res=resample(Y,n,length(Y));
    norm_Y = round((y_res - min(y_res)) / ( max(y_res) - min(y_res) )*n);
    norm_X(norm_X==0)=1;
    norm_Y(norm_Y==0)=1;
    norm_Pressure=round((Pressure_res - min(Pressure_res)) / ( max(Pressure_res) - min(Pressure_res) )*255);
    m=zeros(n);
    
    for j=2:length(norm_X)
        m(norm_Y(j),norm_X(j))=norm_Pressure(j)*EndPts_res(j);
        if(norm_Pressure(j-1)*EndPts_res(j-1)>0)
            m=func_Drawline(m, norm_Y(j-1), norm_X(j-1), norm_Y(j), norm_X(j), norm_Pressure(j));
        end
    end
    m=m(:,1:n);    
    splitPath=strsplit(FileName,'\');
    userID=strsplit(char(splitPath(end)),'_');
    users{end+1}=char(userID(1));
    
    dataSetName=['userdata\' char(userID(1)) '_dataset.mat'];
    labelsName=['userdata\' char(userID(1)) '_labels.mat'];
    if (~exist(['userdata\' char(userID(1)) '_dataset.mat'], 'file'))
        dataset=[];
        dataset(:,:,1)=m;
        labels=[];
        %     put label
        if (strcmp(userID(2),'f'))
            labels(end+1)=2;
        else
            labels(end+1)=1;
        end
        save(dataSetName, 'dataset');
        save(labelsName,'labels');
    else
        dataset=load(['userdata\' char(userID(1)) '_dataset.mat']);
        dataset=getfield(dataset,'dataset');
        dataset(:,:,size(dataset,3)+1)=m;
        save(dataSetName, 'dataset');
        
                %     put label
        labels=load(['userdata\' char(userID(1)) '_labels.mat']);
        labels=getfield(labels,'labels');
        if (strcmp(userID(2),'f'))
            labels(end+1)=2;
        else
            labels(end+1)=1;
        end
        save(labelsName,'labels');
    end
%     userID=userID(1);
%     dataSet(:,:,i)=m;
%     put label
%     if (strcmp(userID(2),'f'))
%         dataSetLabels{end+1}=[char(userID(1)) '_f'];
%     else
%         dataSetLabels{end+1}=[char(userID(1)) '_g'];
%     end
    
    
    
%     if(strcmp(splitPath{end-2},'VALIDATION'))
%         testSetCounter=testSetCounter+1;
%         testSet(:,:,testSetCounter)=m;
%         if(strcmp(splitPath{end-1},'VALIDATION_GENUINE'))
%             testSetLabels{end+1}=[char(userID) '_g'];
%         else
%             testSetLabels{end+1}=[char(userID) '_f'];
%         end
%     else
%         trainingSetCounter=trainingSetCounter+1;
%         trainingSet(:,:,trainingSetCounter)=m;
%         users(end+1)=str2num(char(userID));
%         if(strcmp(splitPath{end-1},'FORGERY'))
%             trainingSetLabels{end+1}=[char(userID) '_f'];
%             
%         else
%             trainingSetLabels{end+1}=[char(userID) '_g'];
%         end
        
    clear memory
      
end
uniqueUsers=unique(users);
save('uniqueUsers.mat','uniqueUsers');
% [C,~,ib] = unique(dataSetLabels);  
% dataSetLabels=ib;
% 
% num_points = size(dataSet,3);
% split_point = round(num_points*0.7);
% seq = randperm(num_points);
% X_train = dataSet(:,:,seq(1:split_point));
% Y_train = dataSetLabels(seq(1:split_point));
% X_test = dataSet(:,:,seq(split_point+1:end));
% Y_test = dataSetLabels(seq(split_point+1:end));
%     
%     

    
% end



