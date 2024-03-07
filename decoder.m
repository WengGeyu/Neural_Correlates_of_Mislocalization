%% decoder result from population of neurons
load('decoder.mat')

pre = 87:101;
peri = 108:122; 
pre_con = nanmean([squeeze(nanmean(less_confusion(:,2,1,pre),4)'*100);squeeze(nanmean(less_confusion(:,3,2,pre),4)'*100);squeeze(nanmean(less_confusion(:,3,1,pre),4)'*100)]);
peri_con = nanmean([squeeze(nanmean(less_confusion(:,2,1,peri),4)'*100);squeeze(nanmean(less_confusion(:,3,2,peri),4)'*100);squeeze(nanmean(less_confusion(:,3,1,peri),4)'*100)]);
pre_incon = nanmean([squeeze(nanmean(less_confusion(:,2,3,pre),4)'*100);squeeze(nanmean(less_confusion(:,1,2,pre),4)'*100);squeeze(nanmean(less_confusion(:,1,3,pre),4)'*100)]);
peri_incon = nanmean([squeeze(nanmean(less_confusion(:,2,3,peri),4)'*100);squeeze(nanmean(less_confusion(:,1,2,peri),4)'*100);squeeze(nanmean(less_confusion(:,1,3,peri),4)'*100)]);
scatter(pre_con,peri_con,'filled','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5)
xlabel('fixation (% decoded)')
ylabel('perisaccadic (% decoded)')
hold on
axis([10 45 10 45])
axis square
scatter(pre_incon,peri_incon,'filled','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5)
axis square
axis([10 45 10 45])
legend('same as saccade direction','opposite to saccade direction')

%% run decoder for every neuron
time = -700:7:700;
st = [5 5;2 5;2 5;2 5;6 7;2 7;7 7;7 4;7 5;4 5;5 5;5 5;2 5;2 5;2 6];
guide = [-1 -1; -1 0; -1 1; 0 -1; 0 0; 0 1; 1 -1; 1 0; 1 1];
direction = [1,-1,-1,-1,-1,-1,1,1,1,-1,1,1,-1,-1,-1];
sguide = [0 -1; 0 0; 0 1; 1 -1; 1 0; 1 1];
for group = 2:16
    cguide = guide;
    cguide(:,1) = guide(:,1)*direction(group-1);
    list = ind{group};
for n = 1:size(list,1)
    num_decoded = zeros(9,9,6,length(time));
    num_presented = zeros(9,6,length(time));
    for tbin = 1:length(time) % continuous time    
        id = info.id(list(n));
        if(info.ch(list(n))<10) 
            ch  = ['0' num2str(info.ch(list(n)))];
        else
            ch = num2str(info.ch(list(n)));
        end
        un = info.un(list(n));
        folder = '\resp\';
        load([folder 'resp_' num2str(id) '_' num2str(ch) '_' num2str(un)],'resp')
        response = squeeze(nanmean(resp(tbin,:,:,:,50:100),5))*1000;            
        trials = nan(size(response,3),9,9);
        for r = 1:size(response,3)
            trials(r,:,:) = response(:,:,r);
        end

        [train,index] = datasample(trials,round(size(trials,1)*0.8),'Replace',false);
        test = trials(setdiff(1:size(trials,1),index),:,:,:);
        ST_train = nan(size(train,1),9);
        ST_test = nan(size(test,1),9);
        for s = 1:6
            center = [st(group-1,1)+sguide(s,1) st(group-1,2)+sguide(s,2)];
            for p = 1:size(cguide,1)
                ST_train(:,p) = squeeze(train(:,center(1)+cguide(p,1),center(2)+cguide(p,2)));
                ST_test(:,p) = squeeze(test(:,center(1)+cguide(p,1),center(2)+cguide(p,2)));
            end

            Bin_C = 10;
            FR_count = nan(9,Bin_C);
            FR_code = nan(9,Bin_C/2);
            EDGES = nan(9,Bin_C+1);
            BMIN = min(ST_train(:));
            BMAX = max(ST_train(:));
            if isnan(BMIN) || isnan(BMAX)
                BMIN = 0;
                BMAX = 0;
            end
            for k = 1:9
                [FR_count(k,:),EDGES(k,:)] = histcounts(ST_train(:,k),Bin_C,'BinLimits',[BMIN,BMAX]);
            end
            % combine second half of bins
            FR_count(:,Bin_C/2) = sum(FR_count(:,Bin_C/2:end),2);
            FR_count(:,(Bin_C/2+1):end) = [];
            EDGES(:,(Bin_C/2+1)) = EDGES(:,end);
            EDGES(:,(Bin_C/2+2):end) = [];
            for k = 1:9
                FR_code(k,:) = FR_count(k,:)*(sum(~isnan(squeeze(ST_train(:,k))))/sum(sum(~isnan(squeeze(ST_train)))));
            end    

            predicted_probe = cell(size(ST_test,1),9);
            for t = 1:size(ST_test,1)
                for p = 1:9
                    if ~isnan(ST_test(t,p))
                        [~,I] = nanmin(abs(EDGES(1,1:end-1)+mean([EDGES(1,2),EDGES(1,1)])-ST_test(t,p)));
                        predicted_probe(t,p) = {find(FR_code(:,I)==nanmax(FR_code(:,I)))};
                        for q = 1:9
                            if size(predicted_probe{t,p},1) > 1
                                if sum(predicted_probe{t,p} == q) == 1
                                    num_decoded(p,q,s,tbin) = num_decoded(p,q,s,tbin) + 1/size(predicted_probe{t,p},1);
                                end
                            else
                                if predicted_probe{t,p} == q
                                    num_decoded(p,q,s,tbin) = num_decoded(p,q,s,tbin) + 1;
                                end
                            end
                        end
                    end
                    num_presented(p,s,tbin) = sum(~isnan(squeeze(ST_test(:,p))));
                end    
            end
        end
    end
    n
end
group
end





