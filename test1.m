function acc= test1(classes,sample)
w = warning ('off','all');
count=0;
total=size(sample,1);
for i=1:size(sample,1)
    train= sample(i,:);
    sample1=sample;
    sample1(i,:)=[];
    test=classes(i);
    test1=classes;
    test1(i)=[];
    class = knnclassify(train, sample1, test1);
    for i=1:size(test)
     if class(i)==test(i)
     count=count+1;  
     end
    end
end
acc=(count/total)*100;
