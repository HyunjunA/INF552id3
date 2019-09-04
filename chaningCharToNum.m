function n=chaningCharToNum(T)


n=[];
%    for ind=1:length(T.Properties.VariableNames)
%        c = categorical(T.Enjoy_)
% %        c = categorical(B(:,ind))
% %        c=B(:,ind)
%        numericalDataTemp = grp2idx(c)
%        n=[n numericalDataTemp]       
%    end

c = categorical(T.x_Occupied);
c=string(c);
numericalDataTemp = grp2idx(c);

% c=string(c)
% [G,GN]=grp2idx(c)
% [G,GN,GL] = grp2idx(c)

n=[n numericalDataTemp]       ;

c = categorical(T.Price);
[G,GN]=grp2idx(c);
[G,GN,GL] = grp2idx(c);

numericalDataTemp = grp2idx(c);
n=[n numericalDataTemp]       ;

c = categorical(T.Music);
numericalDataTemp = grp2idx(c);
n=[n numericalDataTemp]       ;

c = categorical(T.Location);
numericalDataTemp = grp2idx(c);
n=[n numericalDataTemp]       ;

c = categorical(T.VIP);
numericalDataTemp = grp2idx(c);
n=[n numericalDataTemp]       ;

c = categorical(T.FavoriteBeer);
numericalDataTemp = grp2idx(c);
n=[n numericalDataTemp]       ;


c = categorical(T.Enjoy_);
numericalDataTemp = grp2idx(c);
numericalDataTemp=numericalDataTemp-1;
n=[n numericalDataTemp] ;      
     
  
end
