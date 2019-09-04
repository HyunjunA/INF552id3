function [tree]=id3_tree(examples,Features,activeFeatures,num_labels)
% ID3 algorithms

% input parameter:
% example : input data matrix;
% Features : occupied, price,music,location,vip,favorite beer
% activeAttibutes : 1 represents active state

% output parameter:
% tree : decision tree

%if the examples are null, print unusual".

%activiate all Features

if (isempty(examples))
    
    error('MUST PROVIDE EXAMPLES');
end

% constant
numberFeatures = length (activeFeatures);
numberExamples = length (examples(:,1)); 

% create tree node
tree = struct();


% if 'enjoy' outcomes are all 1, return "yes"
lastColumnSum = sum(examples(:,numberFeatures+1));

if (lastColumnSum == numberExamples)
    tree.value = 'yes';
    return
end
% if 'enjoy' outcomes are all 0, return "no"
if (lastColumnSum == 0)
    tree.value = 'no';    
    return
end

% if there is no active attribute? return the value which is more.
if (sum(activeFeatures) == 0)
    if(lastColumnSum > numberExamples /2)
        tree.value = 'yes';
    elseif(lastColumnSum == numberExamples /2)
        tree.value = 'tie';
        else
        tree.value = 'no';
    end
    return
end

%£¥£¥£¥£¥£¥£¥£¥£¥Infomation Gain Calculation£¥£¥£¥£¥£¥£¥ 
bestFeature = InfoGain(examples, num_labels, activeFeatures); %find the best feature

% get a node
tree.value = Features(bestFeature);

%make the bestattribute unactive
activeFeatures(bestFeature) = 0;

% when examples just one
LabelsNum = num_labels(bestFeature);

for j = 1:LabelsNum
     eg = examples(examples(:,bestFeature) == j,:);
    %if eg{j} is a leaf
    if (isempty(eg))
        leaf = struct('value','null');
        if(lastColumnSum > numberExamples/2)
            leaf.value = 'yes';
        else
            if(lastColumnSum == numberExamples/2)
                leaf.value = 'tie';
            else
                leaf.value = 'no';
            end
        end

               tree.child{j} = leaf;

    else

          tree.child{j} = id3_tree(eg,Features,activeFeatures,num_labels);
    end 
end

%% Prune tree branch
queue=0;
bit = length(fieldnames(tree.child{1}));
for k = 1:LabelsNum
  if( bit == length(fieldnames(tree.child{k}))) %if the nodes are all final value, 
    temp(k) = tree.child{k}(1,1);
    as{k} = temp(k).value;
    if(~iscell(as{k}))
        queue = queue +1; %the number of leaves
    end
  else
      return;
  end

end

  %Compare the value if they are all leaves
  if(queue == LabelsNum) %here is the last level
      for m = 1:LabelsNum-1
      b1 = as{m};
      b2 = as{m+1};
        if(strcmp(b1,b2)==0) % if b1 is same with b2, return 1
           return;
         end
      end
           tree.value = tree.child{1}.value; %father node's value = the final value
           tree = rmfield(tree,'child'); %delete the child 
  end
    

    

return
end




    


    
