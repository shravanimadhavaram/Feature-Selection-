disp('Welcome to Bertie Woosters Feature Selection Algorithm.');
prompt = 'Type in the name of the file to test :';
filename = strcat('C:/Users/shrav/Desktop/cs_205_NN_datasets/',input(prompt));
delimiterIn = ' ';
B=importdata(filename,delimiterIn);
A=normc(B(:,2:size(B,2)));
disp('Type the number of the algorithm you want to run.');
disp('1)	Forward Selection');
disp('2)	Backward Elimination ');
prompt = '3)	Bertie’s Special Algorithm.';
algo = input(prompt);
X = sprintf('This dataset has %d features (not including the class attribute), with %d instances.',size(A,2),size(A,1));
disp(X);
disp('Please wait while I normalize the data…   Done!');
all=(1:size(A,2));
class=B(:,1);
sample1=A(:,all);
acc=test1(class,sample1);
X = sprintf('Running nearest neighbor with all %d features, using “leaving-one-out” evaluation, I get an accuracy of %d %',size(A,2),acc);
disp(X);
disp('Beginning search.');
%forward selection
if( algo == 1 )
currentList=[];
finalList=[];
classes=B(:,1);
finalMax=0;
for i=1:(size(A,2))
   maxvalue=0;
   for j=1:(size(A,2))
       if ~ismember(j,currentList)
           list=[currentList j];
           sample=A(:,list);
           acc=test1(classes,sample);
           g=sprintf('%d ', list);
           fprintf('Using feature(s) %s accuracy is %d\n',g,acc);
           if acc>=maxvalue
               maxvalue=acc;
               maxId=j;
           end
       end
   end
   currentList=[currentList maxId];
   g=sprintf('%d ', currentList);
   fprintf('Feature set %s was best, accuracy is %d\n',g,maxvalue);
   if maxvalue>finalMax
      finalList =currentList;
      finalMax=maxvalue;
   else
       disp('(Warning, Accuracy has decreased! Continuing search in case of local maxima)');
   end
end
g=sprintf('%d ', finalList);
fprintf('Finished search!! The best feature subset is %s, which has an accuracy of %d\n',g,finalMax);
%backward selection
elseif (algo ==2)
        currentList=(1:size(A,2));
finalList=[];
classes=B(:,1);
finalMax=0;

for i=1:(size(A,2)-1)
   maxvalue=0;
   for j=1:(size(A,2))
       if ismember(j+1,currentList)
           list=currentList;
           list(list==j+1) = [];
           sample=A(:,list);
           acc=test1(classes,sample);
           g=sprintf('%d ', list);
           fprintf('Using feature(s) %s accuracy is %d\n',g,acc);
           if acc>=maxvalue
               maxvalue=acc;
               maxId=j+1;
           end
       end
   end
   currentList(currentList==maxId)=[];
   g=sprintf('%d ', currentList);
   fprintf('Feature set %s was best, accuracy is %d\n',g,maxvalue);
   if maxvalue>finalMax
      finalList =currentList;
      finalMax=maxvalue;
   else
      disp('(Warning, Accuracy has decreased! Continuing search in case of local maxima)');
   end
end
g=sprintf('%d ', finalList);
fprintf('Finished search!! The best feature subset is %s, which has an accuracy of %d\n',g,finalMax);

elseif( algo == 3)
currentList=[];
for i=1:(size(A,2))
           sample=A(:,i);
           acc=test1(classes,sample);
            fprintf('Using feature(s) %d accuracy is %d\n',i,acc);
           currentList=[currentList acc];
end
[B,I] = sort(currentList,'descend');
maxvalue=0;
for j=1:(size(I,2))
    finalList=I(:,j);
    acc1=currentList(j);
for i=j+1:(size(I,2))
     list=[finalList I(:,i)];
     sample=A(:,list);
     acc=test1(classes,sample);
     if acc1 < acc
         finalList = [finalList I(:,i)];
         acc1=acc;
     end
     g=sprintf('%d ', list);
     fprintf('Using feature(s) %s accuracy is %d\n',g,acc);
     if acc>maxvalue
        maxvalue=acc;
        final=list;
     end
end
end
g=sprintf('%d ', final);
fprintf('Finished search!! The best feature subset is %s, which has an accuracy of %d\n',g,maxvalue);

end
