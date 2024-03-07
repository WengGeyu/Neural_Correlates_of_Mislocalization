%% spatial bias
load('spatial_bias.mat')

subplot(2,1,1)
niceplot3(-540:540,squeeze(spatial_bias(:,:,1)),50,.5,.5,.9);
hold on
niceplot3(-540:540,squeeze(spatial_bias(:,:,2)),50,.9,.5,.5);
yline(0,'k--','LineWidth',3)
xlim([-300 300])
ylim([-.3 .3])
xlabel('time of response from saccade onset (ms)')
ylabel('spatial bias (unit)')

subplot(2,1,2)
for g = 1:15
    peri_bias(:,g) = squeeze(nanmean(resampled_bias(g,:,541+50:541+150),2));
    mean_peri_bias(g) = nanmean(peri_bias(:,g));
    sem_peri_bias(g) = nanstd(peri_bias(:,g))/sqrt(length(peri_bias(:,g)));
end
scatter(d,mean_peri_bias,80,[.7 .5 .5],'filled')
hold on
yline(0,'--','LineWidth',3,'Color',[0 0 0])
xlabel('distance between RF center and ST (dva)')
ylabel('spatial bias (unit)')
xlim([2 22])
e = errorbar(d,mean_peri_bias,sem_peri_bias,sem_peri_bias,'.');
e.Color = 'black';
title('RF distance vs. spatial bias')
