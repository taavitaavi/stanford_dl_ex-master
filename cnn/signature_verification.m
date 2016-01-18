uniqueUsers=load('../SUsig/uniqueUsers');
uniqueUsers=getfield(uniqueUsers,'uniqueUsers');

for i=1:length(uniqueUsers)
    user=uniqueUsers(i);
    userdata=load(['../SUsig/userdata/' char(user) '_dataset.mat']);
    userdata=getfield(userdata,'dataset');
    dataLabels=load(['../SUsig/userdata/' char(user) '_labels.mat']);
    dataLabels=getfield(dataLabels,'labels');
    dataLabels=dataLabels';
%     create training and test set
    num_points = size(userdata,3);
    split_point = round(num_points*0.8);
    seq = randperm(num_points);
    X_train = userdata(:,:,seq(1:split_point));
    Y_train = dataLabels(seq(1:split_point));
    X_test = userdata(:,:,seq(split_point+1:end));
    Y_test = dataLabels(seq(split_point+1:end));
    acc=cnnTrain_on_user(X_train,Y_train,X_test,Y_test);
    
end
