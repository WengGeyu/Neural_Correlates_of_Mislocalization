% size (trial X time)

function [y, sem] = niceplot3(xinput,yinput, win, c1, c2, c3)

for k=1:size(yinput,1)
    jnk(k,:)=smoothdata(yinput(k,:),'movmean',win);
end
matr=jnk(:,:);
y=nanmean(matr);
sem = nanstd(matr)./(size(matr, 1).^.5);
y1=nanmean(matr)+sem;
y2=nanmean(matr)-sem;
% y1=nanmean(matr)+nanstd(matr); % ./sqrt(sum(matr==matr,1));
% y2=nanmean(matr)-nanstd(matr); % ./sqrt(sum(matr==matr,1));

y3=y2(size(matr, 2):-1:1);
y2=y3;
Y=[y1 y2];

x1=xinput;
x2=flip(xinput);
X=[x1 x2];
fill(X(~isnan(Y)), Y(~isnan(Y)), [c1 c2 c3], 'LineStyle', 'none');
alpha(0.2)
hold on;
plot(xinput, y,  'color', [c1 c2 c3],'LineWidth',3);



