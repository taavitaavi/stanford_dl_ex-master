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

    h=dialog ( 'visible', 'off', 'windowstyle', 'normal' );
    ax=axes('parent', h);
    plot (ax,X,-Y,'color','k');
    set(ax, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
    set(gca,'xcolor','w','ycolor','w','xtick',[],'ytick',[])
    set(gcf,'color','w');
    %get filename
    f=strsplit(FileName,'\');
    f=f(end);
    f=strsplit(f{1},'.');
    f=f{1};
    saveas (ax,[folder f], 'png' )
    close(h)
    
    im=imread([folder f '.png']);
    BW = im2bw(im, 0.5);
%     stats = [regionprops(BW); regionprops(not(BW))];
%     rect=stats(2).BoundingBox;
%     cropped=imcrop(BW,rect);
%     imshow(cropped);
    images(:,:,i)=BW;
    
end



