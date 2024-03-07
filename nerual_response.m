%% neural response at ST
load('neural_response.mat')

figure
subplot(2,2,1)
niceplot3(1:200,squeeze(nanmean(response_close_fix(:,1,[1 2 3],:),3)),15,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_close_fix(:,1,[4 5 6],:),3)),15,79/255,157/255,166/255);
xlim([0 180])
ylim([0.95 1.13])
axis square
title('model')
ylabel('response (a.u.) [fixation]')
subplot(2,2,2)
niceplot3(1:200,squeeze(nanmean(response_close_fix(:,2,[1 2 3],:),3)),50,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_close_fix(:,2,[4 5 6],:),3)),50,79/255,157/255,166/255);
xlim([0 180])
ylim([0.85 1.3])
axis square
title('neuron')
subplot(2,2,3)
niceplot3(1:200,squeeze(nanmean(response_close_peri(:,1,[1 2 3],:),3)),15,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_close_peri(:,1,[4 5 6],:),3)),15,79/255,157/255,166/255);
xlabel('time from stimulus onset (ms)')
ylabel('response (a.u.) [perisaccadic]')
xlim([0 180])
ylim([0.95 1.13])
axis square
subplot(2,2,4)
niceplot3(1:200,squeeze(nanmean(response_close_peri(:,2,[1 2 3],:),3)),50,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_close_peri(:,2,[4 5 6],:),3)),50,79/255,157/255,166/255);
xlabel('time from stimulus onset (ms)')
xlim([0 180])
ylim([0.85 1.3])
axis square
hold off
sgtitle('d < 11')

figure
tstim1 = 30:87;
tstim2 = 101:107;
tstim3 = 110:134;
subplot(3,2,1)
niceplot3(1:200,squeeze(nanmean(response_far_fix(:,1,[1 2 3],:),3)),15,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_far_fix(:,1,[4 5 6],:),3)),15,79/255,157/255,166/255);
xlim([0 180])
ylim([0.97 1.14])
axis square
title('model')
ylabel('response (a.u.) [fixation]')
subplot(3,2,2)
niceplot3(1:200,squeeze(nanmean(response_far_fix(:,2,[1 2 3],:),3)),50,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_far_fix(:,2,[4 5 6],:),3)),50,79/255,157/255,166/255);
xlim([0 180])
ylim([.9 1.2])
axis square
title('neuron')
subplot(3,2,3)
niceplot3(1:200,squeeze(nanmean(response_far_peri(:,1,[1 2 3],:),3)),15,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_far_peri(:,1,[4 5 6],:),3)),15,79/255,157/255,166/255);
xlim([0 180])
ylim([0.97 1.14])
axis square
ylabel('response (a.u.) [perisaccadic]')
subplot(3,2,4)
niceplot3(1:200,squeeze(nanmean(response_far_peri(:,2,[1 2 3],:),3)),50,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_far_peri(:,2,[4 5 6],:),3)),50,79/255,157/255,166/255);
xlim([0 180])
ylim([.9 1.2])
axis square
subplot(3,2,5)
niceplot3(1:200,squeeze(nanmean(response_far_post(:,1,[1 2 3],:),3)),15,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_far_post(:,1,[4 5 6],:),3)),15,79/255,157/255,166/255);
xlim([0 180])
ylim([0.97 1.14])
axis square
xlabel('time from stimulus onset (ms)')
ylabel('response (a.u.) [postsaccadic]')
subplot(3,2,6)
niceplot3(1:200,squeeze(nanmean(response_far_post(:,2,[1 2 3],:),3)),50,250/255,172/255,92/255);
hold on
niceplot3(1:200,squeeze(nanmean(response_far_post(:,2,[4 5 6],:),3)),50,79/255,157/255,166/255);
xlabel('time from stimulus onset (ms)')
xlim([0 180])
ylim([.9 1.2])
axis square
sgtitle('d >= 11')
hold off
