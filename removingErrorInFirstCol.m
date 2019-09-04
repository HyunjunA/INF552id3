function T=removingErrorInFirstCol(T)

 for n=1:21
     temp=table2array(T(n,1));
     ttemp=string(temp);
     expression = '\:';
     splitStr = regexp(ttemp,expression,'split');
     T(n,1)=table(splitStr(2));
 end

 %T=table(T)
