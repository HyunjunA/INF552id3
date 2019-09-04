function [resultTest] = predict_test(data,tree)
%data is test data
%data = [2,1,1,1,1,1]
%data = ['Moderate','Cheap','Loud','City-Center','No','No']
%tree is produced by id3_tree

while 1  
    if(length(fieldnames(tree))==1)
        
        break;
    else
    tree = tree.child{data(tree.value{1})};
    end
end
    resultTest = tree.value;

return
end