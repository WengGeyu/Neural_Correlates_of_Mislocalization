%% behavioral mislocalization

load('mislocalization.mat')

subplot(2,2,1)
niceplot3(-200:200,misloc1,5,.9,.3,.3);
xlim([-180 150])
ylim([-0.7 0.7])
xlabel('time of stimulus presentation from saccade onset (ms)')
ylabel('mislocalization (dva)')
title('mislocalization (Monkey 1)')
subplot(2,2,3)
niceplot3(-200:200,misloc2,5,.9,.3,.3);
xlim([-180 150])
ylim([-0.7 0.7])
xlabel('time of stimulus presentation from saccade onset (ms)')
ylabel('mislocalization (dva)')
title('mislocalization (Monkey 2)')
subplot(2,2,2)
scatter(loc_err1(:,1),loc_err1(:,2))
xlabel('fixation (-250:-150 ms)')
ylabel('perisaccadic (-80:20 ms)')
axis([-4 4 -4 4])
axis square
title('localization error (Monkey 1)')
subplot(2,2,4)
scatter(loc_err2(:,1),loc_err2(:,2))
xlabel('fixation (-250:-150 ms)')
ylabel('perisaccadic (-120:-40 ms)')
axis([-4 4 -4 4])
axis square
title('localization error (Monkey 2)')
