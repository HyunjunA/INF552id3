%% Group Information
% NAME                     WORKLOAD
% Wanjin Li                InfoGain/Print Tree/Combine codes/Prune brunch/Debugging
% Taoran Ju                ID3 Tree/Debugging/Optimization/Prediction/Part2
% Hyun Jun Choi            Data preprocessing/Part3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data preprocessing
%Reading txt file
A = importdata('dt-data.txt');
formatSpec = '%C%C%C%C%C%C%C ';
T = readtable('dt-data.txt','Delimiter',',', ...
    'Format',formatSpec);

%Processing the first row of T
T=removingErrorInFirstCol(T);

%chaning all charater to number 
NumericalValueTable=chaningCharToNum(T);

%changing NumericalValueTable to table by variables
NumericalValueTable = array2table(NumericalValueTable,...
    'VariableNames',{'Occupied','Price','Music','Location','Vip','FavoriteBeer','Enjoy'});

%number of labels' catagories in each feature
FeaturesNum = width(NumericalValueTable(1,:)) -1 ;
num_labels = zeros(1, FeaturesNum);
Features = {};
for i = 1 : FeaturesNum
    num_labels(1,i) = height(unique(NumericalValueTable(:,i)));
    Features{i} = i;
end   

%activiate all Features
activeFeatures = zeros(1,FeaturesNum);
activeFeatures(1,:) = 1;

% NumericalValueTable = get(NumericalValueTable,'data');
NumericalValueMatrix = NumericalValueTable{:,:};


%% Build Tree
 tree = id3_tree(NumericalValueMatrix,Features,activeFeatures,num_labels);
 
%% Print Tree 
PrintTree(tree, num_labels, NumericalValueTable);

%% Prediction
data = [2,1,1,1,1,1];
resultTest = '0';
resultTest = predict_test(data,tree);
fprintf('The prediction result is: %s \n',resultTest );


%% Build Tree with matlab library
X=T(:,1:6);
Y=T(:,7);
tree2 = fitctree(X,Y); 

view(tree2,'Mode','graph');

data1 = {'Moderate', 'Cheap', 'Loud' ,'City-Center' ,'No' ,'No'};
resultTest2 = predict(tree2,data1);
if(resultTest2=='no')
disp('The prediction result2 is: no');
else
disp('The prediction result2 is: yes');
end






   
   
   
  
