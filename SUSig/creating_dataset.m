% Create trainingset
startingfolder='C:\Users\taavi\Dropbox\kool2\kool\2015sygis\deep learning\SUSig\VisualSubCorpus\';
[ fullFileNames ] = getfullFilenames( startingfolder );
ShowSig=0;
folder='C:\Users\taavi\Dropbox\kool2\kool\2015sygis\deep_learning\SUSig\images\';
images=[];
for i=1:length(fullFileNames)
    disp(['image ' int2str(i)]);
    FileName=fullFileNames{i};

    [X Y TStamp Pressure EndPts]=ReadSignature(FileName,ShowSig);
    n=200;
    Pressure_res=resample(Pressure,n,length(Pressure));
    x_res=resample(X,n,length(X));
    norm_X = round((x_res - min(x_res)) / ( max(x_res) - min(x_res) )*n);
    y_res=resample(Y,n,length(Y));
    norm_Y = round((y_res - min(y_res)) / ( max(y_res) - min(y_res) )*n);
    norm_X(norm_X==0)=1;
    norm_Y(norm_Y==0)=1;
    m=zeros(n);
    norm_Pressure=round((Pressure_res - min(Pressure_res)) / ( max(Pressure_res) - min(Pressure_res) )*255);
    for j=2:length(norm_X)
        norm_Pressure(j)
        m(norm_Y(j),norm_X(j))=norm_Pressure(j);
        m=func_Drawline(m, norm_Y(j-1), norm_X(j-1), norm_Y(j), norm_X(j), norm_Pressure(j));
    end
    
    

    
end



