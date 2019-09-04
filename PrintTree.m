function PrintTree(tree, num_labels, NumericalValueTable) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%   tree: Decision tree model.
%   num_labels: The number of labels' catagories for each feature.
%   NumericalValueTable: Training examples' data table(in number format).
% Output:
%   Tree printing. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(tree)
    return;
end

%% Change depth-first traversal to breadth traversal
id = 0; %current node's id
fatherID(1) = 0; %the head node doesn't have father
PrintValue = {};
PrintString = {};
list = {tree};

while ~isempty(list)
    node = list{1}; 
    list_length = length(list);
    id = id +1;
    if(length(fieldnames(node)) > 1) %not leaf
       children_num = length(node.child);
       childID_1st = id + list_length;
       childID_end = id + list_length + children_num - 1;
       fatherID(childID_1st:childID_end) = id;
       
       %add children to list
       for i = 1:children_num
           list{list_length+i}  = node.child{i};

       end
    end %is leaf - just add itself
       
       PrintValue{1,id} = node.value;
       if(length(fieldnames(node)) > 1) %not leaf
            PrintString{1,id} =  NumericalValueTable.Properties.VariableNames(node.value{1});
       else
            PrintString{1,id} =  node.value;
       end
       list = list(2:end);%pop the first node
end

%% printing the tree
totalChildren = 0;%totalChildren in Next level
num_thislevel = 1;

count = 0;num_previousLevel =0;
while(count < id)
    
    for j = 1:num_thislevel %1    2  7
        current_id = j+num_previousLevel;
        father_id = fatherID(current_id);
        if(father_id == 0)% the head node
          fprintf(char(PrintString{1,current_id}));%1    23   4-10
        else %child node(father node)
          fprintf('%s(%s),',char(PrintString{1,current_id}),char(PrintString{1,father_id}));%1    23   4-10
        end
        if(~ischar(PrintValue{current_id})) 
           totalChildren = totalChildren + num_labels(cell2mat(PrintValue{current_id}));
        end
            
        count = count + 1; %1   23   4-10
    end
    fprintf('\n\n');
    num_previousLevel = count;%1  3   10
    num_thislevel = totalChildren;%2  7
    totalChildren = 0;
end






