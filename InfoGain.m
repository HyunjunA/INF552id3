function bestFeature = InfoGain(Examples, labels_number, activeFeatures)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%   Examples: Training examples' data table that comes from every selection.
%   labels_number: The number of labels' catagories for each feature.
%   activeFeatures: The features that haven't been use as the node.
% Output:
%   bestFeature: The index of the bestFeature for current node. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
feature_number = length(Examples(1,:)) -1;
numberExamples = length(Examples(:,1));
num_yes = 0;
num_no = 0;

%% Current Entropy
if(numberExamples > 0)
  for j = 1:numberExamples
        if(Examples(j,feature_number + 1) == 1)
            num_yes =  num_yes + 1;
        else
            num_no = num_no + 1;
        end
  end
  p_yes = num_yes/numberExamples;
  p_no = 1 - p_yes;
  
  if(num_yes == 0) 
      p1 = 0;
  else
      p1 = (-1)*(p_yes)*log2(p_yes) ;
  end
  if(num_no == 0) 
      p2 = 0;
  else
      p2 = (-1)*(p_no)*log2(p_no) ;
  end      
end 
  currentEntropy = p1 + p2; 
%% Find the best

infoGain_feature = -1*ones(1,feature_number); %minus???

for k=1:feature_number
    if (activeFeatures(k)==1) 
% how many kinds of label
labels_catagory_num = labels_number(k);

% how many items in each label
label_hist_entrop = zeros(labels_catagory_num,3);
label_hist_entrop(:,1) = 1:labels_catagory_num;
label = label_hist_entrop(:,1)';

new_entropy = 0;
result_no = 0;
result_yes = 0;
for i = 1:labels_catagory_num

    %caculate every entropy of each label
    for s = 1:numberExamples
         
        if(Examples(s,k) == label(i))
            label_hist_entrop(i,2) = label_hist_entrop(i,2)+1; %number of each label's items            
            if(Examples(s,feature_number + 1) == 1) %yes == 1
              result_yes =  result_yes + 1;
            else
              result_no = result_no + 1;
            end
        end
    end


    if (label_hist_entrop(i,2) == 0)%no data in that label
        p_yes = 0;
        p_no = 0;
    else
    p_yes = result_yes/label_hist_entrop(i,2);
    p_no = 1 - p_yes;
    end
    
    if(p_yes == 0)
        pp1 = 0;
    else pp1 = -1*(p_yes)*log2(p_yes); 
    end
    if(p_no == 0)
        pp2 = 0;
    else  pp2 = -1*(p_no)*log2(p_no);
    end   
    label_hist_entrop(i,3) =  pp1 + pp2; 
    ref = label_hist_entrop(i,2)/numberExamples;
    
    result_no = 0;
    result_yes = 0;
    
   %entropy of feature
    new_entropy = new_entropy + ref * label_hist_entrop(i,3);  
end

%Find Max Information Gain
    infoGain_feature(k) = currentEntropy - new_entropy;

    end
end

%% Find the best
[maxinfoGain,bestFeature] = max(infoGain_feature);



