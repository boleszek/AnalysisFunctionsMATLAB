%% Plot SALINE sessions

% plot ch1 and ch2 on same axes 

% BLANK sessions
if nb > 0
    
for pp = 1:nb
figure
set(gcf,'position',[100,200,1700,700])
for ii = 1:nt
    subplot(nt,1,ii)
    hold on
    plot(twin,BLANKtrials.(chan_names{ch1}){1}(:,ii+nt*(pp-1)),'k')
    plot(twin,BLANKtrials.(chan_names{ch2}){1}(:,ii+nt*(pp-1)),'r')
    axis off
    axis tight
end
axis on
legend({chan_names{ch1},chan_names{ch2}},'fontsize',lfs,'position',[0.84,0.2,0.01,0.06])
set(gca,'YTick',[],'fontsize',afs); set(gca,'XTick',[],'fontsize',afs)
xlabel([num2str(pre+post),'s'])
xlim([-pre post])
suptitle(['Blank session ',num2str(pp),', Saline'])
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_',Ssess,'_','B',num2str(pp),'.tif'];
    saveas(gcf,fname)
end
end

end

% ODOR sessions
for pp = 1:no
figure
set(gcf,'position',[100,200,1700,700])
    if exist('intrep','var')
        trial_inds = [];
        for jj = 1:intrep
            % interleaved (pres intrep times)
            trial_inds = [trial_inds, jj:2*intrep:no*nt];
        end
        trial_inds = sort(trial_inds)+(intrep*(pp-1));
    else
        trial_inds = ((pp-1)*nt+1):pp*nt;
    end
for ii = 1:nt
    subplot(nt,1,ii)
    hold on
    plot(twin,ODORtrials.(chan_names{ch1}){1}(:,trial_inds(ii)),'k')
    plot(twin,ODORtrials.(chan_names{ch2}){1}(:,trial_inds(ii)),'r')
    axis off
    axis tight
end
axis on
legend({chan_names{ch1},chan_names{ch2}},'fontsize',lfs,'position',[0.84,0.2,0.01,0.06])
set(gca,'YTick',[],'fontsize',afs);set(gca,'XTick',[],'fontsize',afs)
xlabel([num2str(pre+post),'s'])
xlim([-pre post])
suptitle([odor_names{pp},' session, Saline'])
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_',Ssess,'_',odor_names{pp},'.tif'];
    saveas(gcf,fname)
end
end

%% Plot DRUG sessions

% plot ch1 and ch2 on same axes 

% BLANK sessions
if nb > 0
    
for pp = 1:nb
figure
set(gcf,'position',[100,200,1700,700])
for ii = 1:nt
    subplot(nt,1,ii)
    hold on
    plot(twin,BLANKtrials.(chan_names{ch1}){2}(:,ii+nt*(pp-1)),'k')
    plot(twin,BLANKtrials.(chan_names{ch2}){2}(:,ii+nt*(pp-1)),'r')
    axis off
    axis tight
end
axis on
legend({chan_names{ch1},chan_names{ch2}},'fontsize',lfs,'position',[0.84,0.2,0.01,0.06])
set(gca,'YTick',[],'fontsize',afs); set(gca,'XTick',[],'fontsize',afs)
xlabel([num2str(pre+post),'s'])
xlim([-pre post])
suptitle(['Blank session ',num2str(pp),', ',drug_name])
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_',Dsess,'_','B',num2str(pp),'.tif'];
    saveas(gcf,fname)
end
end

end

% ODOR sessions
for pp = 1:no
figure
set(gcf,'position',[100,200,1700,700])
    if exist('intrep','var')
        trial_inds = [];
        for jj = 1:intrep
            % interleaved (pres intrep times)
            trial_inds = [trial_inds, jj:2*intrep:no*nt];
        end
        trial_inds = sort(trial_inds)+(intrep*(pp-1));
    else
        trial_inds = ((pp-1)*nt+1):pp*nt;
    end
for ii = 1:nt
    subplot(nt,1,ii)
    hold on
    plot(twin,ODORtrials.(chan_names{ch1}){2}(:,trial_inds(ii)),'k')
    plot(twin,ODORtrials.(chan_names{ch2}){2}(:,trial_inds(ii)),'r')
%     ylim(YL)
    axis off
    axis tight
end
axis on
legend({chan_names{ch1},chan_names{ch2}},'fontsize',lfs,'position',[0.84,0.2,0.01,0.06])
set(gca,'YTick',[],'fontsize',afs); set(gca,'XTick',[],'fontsize',afs)
xlabel([num2str(pre+post),'s'])
xlim([-pre post])
suptitle([odor_names{pp},' session, ',drug_name])
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_',Dsess,'_',odor_names{pp},'.tif'];
    saveas(gcf,fname)
end
end

% % choosing individual trials for poster
% 9,13 emb  9,15 ger
% set(gcf,'position',[100,200,750,170])
% hold on
%     plot(twin(1:(end/2)),ODORtrials.(chan_names{ch1}){2}(1:(end/2),nt+15),'k')
%     plot(twin(1:(end/2)),ODORtrials.(chan_names{ch2}){2}(1:(end/2),nt+15),'r')
%     axis off
%     axis tight