function bias_n = find_bias(kernel,group)

cos_co = nan(7,7,1081,200,8);
cguide = [+1,+1;0,+1;-1,+1;-1,0;
          -1,-1;0,-1;+1,-1;+1,0];
for p = 1:7
    for q = 1:7
        for c = 1:8
            for t = 1:size(kernel,4)
                for tau = 1:size(kernel,5)                
                    cos_co(p,q,t,tau,c) = dot(squeeze(kernel(:,p+1,q+1,t,tau))/norm(squeeze(kernel(:,p+1,q+1,t,tau))),squeeze(kernel(:,p+1+cguide(c,1),q+1+cguide(c,2),t,tau))/norm(squeeze(kernel(:,p+1+cguide(c,1),q+1+cguide(c,2),t,tau))));
                end
            end
        end
    end
end
for p = 1:7
    for q = 1:7
       for t = 1:size(cos_co,3)
           for tau = 1:size(cos_co,4)
               [a(p,q,t,tau,:),b(p,q,t,tau,:)] = pol2cart(deg2rad((1:8)*45)',squeeze(cos_co(p,q,t,tau,:))-squeeze(nanmean(cos_co(p,q,100:400,tau,:),3)));
               [theta(p,q,t,tau),r(p,q,t,tau)] = cart2pol(nanmean(a(p,q,t,tau,:)),nanmean(b(p,q,t,tau,:)));
           end
       end
    end
end
if ismember(group,[2,8,9,10,12,13])
    s = 1;
else
    s = -1;
end
st = [5 5;2 5;2 5;2 5;6 7;2 7;7 7;7 4;7 5;4 5;5 5;5 5;2 5;2 5;2 6]-1;
bias = squeeze(nanmean(nanmean(nanmean(s*a(st(group-1,1):st(group-1,1)+1,st(group-1,2)-1:st(group-1,2)+1,:,:,:),5),2),1));

% normalize
bias_n = 2*(bias-min(bias(:)))/(max(bias(:))-min(bias(:)))-1;

end