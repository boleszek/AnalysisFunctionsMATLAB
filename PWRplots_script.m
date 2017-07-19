
if usebl == 1
%     ylabp = 'log(Norm. Power)';% ylabel
    ylabp = 'Norm. Power';% ylabel
end

if nb > 0
    
% Blank trials
% If trials are not already detrended they must be detrended! Run code below
% dmat1s = detrend(BLANKtrials.(chan_names{ch1}){1}); % s - Saline
% dmat2s = detrend(BLANKtrials.(chan_names{ch2}){1});
% dmat1d = detrend(BLANKtrials.(chan_names{ch1}){2}); % d - Drug
% dmat2d = detrend(BLANKtrials.(chan_names{ch2}){2});
% If trials are already detrended, run code below
dmat1s = BLANKtrials.(chan_names{ch1}){1}; % s - Saline
dmat2s = BLANKtrials.(chan_names{ch2}){1};
dmat1d = BLANKtrials.(chan_names{ch1}){2}; % d - Drug
dmat2d = BLANKtrials.(chan_names{ch2}){2};
[C_BLANKs,ph,s12,s1_BLANKs,s2_BLANKs,f,confc,phie,cerr]=coherencyc(dmat1s,dmat2s,params);
[C_BLANKd,ph,s12,s1_BLANKd,s2_BLANKd,f,confc,phie,cerr]=coherencyc(dmat1d,dmat2d,params);

% ch1 power
titles = {'1st Blank sess';'2nd Blank sess'};
ind = 1;
figure
set(gcf,'position',[100,100,500,450])
for ii = 1:nb
    trial_inds = ((ind-1)*nt+1+skipt):ind*nt;
    if usebl == 1
        pwrs = s1_BLANKs(:,trial_inds) ./ repmat(s1_First5ms_ave,nt-skipt,1)';
        pwrd = s1_BLANKd(:,trial_inds) ./ repmat(s1_First5md_ave,nt-skipt,1)';
%         pwrs = log(s1_BLANKs(:,trial_inds)) ./ repmat(log(s1_First5ms_ave),nt,1)';
%         pwrd = log(s1_BLANKd(:,trial_inds)) ./ repmat(log(s1_First5md_ave),nt,1)';
    else
        pwrs = log(s1_BLANKs(:,trial_inds));
        pwrd = log(s1_BLANKd(:,trial_inds));
    end
    subplot(nb,1,ii)
    H1=shadedErrorBar(f,mean(pwrs,2),std(pwrs,0,2),'b');
    ylim(YLp);title(titles{ii})
    hold on
    H2=shadedErrorBar(f,mean(pwrd,2),std(pwrd,0,2),'r',0.1);
    if usebl == 1
        plot(f,ones(length(f),1),'k--','linewidth',2)
    end
    ind = ind+1;
    set(gca,'fontsize',14)
    if ii == 1
        legend([H1.mainLine H2.mainLine],'Saline',drug_name,'location','northeast')
    end
    ylabel(ylabp)
    xlim(XL)
end
xlabel('Frequency (Hz)')
suptitle(['Blank session ',chan_names{ch1},' power'])
if sff == 1
    fname = [Rname,'_',chan_names{ch1},'_Power_',Ssess,'&',Dsess,'_','B.tif'];
    saveas(gcf,fname)
end

% ch2 power
titles = {'1st Blank sess';'2nd Blank sess'};
ind = 1;
figure
set(gcf,'position',[100,100,500,450])
for ii = 1:nb
    trial_inds = ((ind-1)*nt+1+skipt):ind*nt;
    if usebl == 1
        pwrs = s2_BLANKs(:,trial_inds) ./ repmat(s2_First5ms_ave,nt-skipt,1)';
        pwrd = s2_BLANKd(:,trial_inds) ./ repmat(s2_First5md_ave,nt-skipt,1)';
%         pwrs = log(s2_BLANKs(:,trial_inds)) ./ repmat(log(s2_First5ms_ave),nt,1)';
%         pwrd = log(s2_BLANKd(:,trial_inds)) ./ repmat(log(s2_First5md_ave),nt,1)';
    else
        pwrs = log(s2_BLANKs(:,trial_inds));
        pwrd = log(s2_BLANKd(:,trial_inds));
    end
    subplot(nb,1,ii)
    H1=shadedErrorBar(f,mean(pwrs,2),std(pwrs,0,2),'b');
    ylim(YLp);title(titles{ii})
    hold on
    H2=shadedErrorBar(f,mean(pwrd,2),std(pwrd,0,2),'r',0.1);
    if usebl == 1
        plot(f,ones(length(f),1),'k--','linewidth',2)
    end
    ind = ind+1;
    set(gca,'fontsize',14)
    if ii == 1
        legend([H1.mainLine H2.mainLine],'Saline',drug_name,'location','northeast')
    end
    ylabel(ylabp)
    xlim(XL)
end
xlabel('Frequency (Hz)')
suptitle(['Blank session ',chan_names{ch2},' power'])
if sff == 1
    fname = [Rname,'_',chan_names{ch2},'_Power_',Ssess,'&',Dsess,'_','B.tif'];
    saveas(gcf,fname)
end
% 
% % Average Coherency
% titles = {'1st Blank sess';'2nd Blank sess'};
% ind = 1;
% figure
% set(gcf,'position',[100,0,600,900])
% for ii = 1:nb
%     trial_inds = ((ind-1)*nt+1):ind*nt;
%     subplot(nb,1,ii)
%     H1=shadedErrorBar(f,mean(atanh(C_BLANKs(:,trial_inds)),2),std(atanh(C_BLANKs(:,trial_inds)),0,2),'b');
%     ylim(YLc);title(titles{ii})
%     hold on
%     H2=shadedErrorBar(f,mean(atanh(C_BLANKd(:,trial_inds)),2),std(atanh(C_BLANKd(:,trial_inds)),0,2),'r',0.1);
%     ind = ind+1;
%     if ii == 1
%         legend([H1.mainLine H2.mainLine],'Saline',drug_name,'location','northeast')
%     end
%     ylabel('Coh')
%     xlim(XL)
% end
% xlabel('Frequency (Hz)')
% suptitle(['Blank session ',chan_names{ch1},'-',chan_names{ch2},' atanh(coherency)'])
% if sff == 1
%     fname = [Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Coh_',Ssess,'&',Dsess,'_','B.tif'];
%     saveas(gcf,fname)
% end

end


% ODOR trials
% dmat1s = detrend(ODORtrials.(chan_names{ch1}){1}); % s - Saline
% dmat2s = detrend(ODORtrials.(chan_names{ch2}){1});
% dmat1d = detrend(ODORtrials.(chan_names{ch1}){2}); % d - Drug
% dmat2d = detrend(ODORtrials.(chan_names{ch2}){2});
dmat1s = ODORtrials.(chan_names{ch1}){1}; % s - Saline
dmat2s = ODORtrials.(chan_names{ch2}){1};
dmat1d = ODORtrials.(chan_names{ch1}){2}; % d - Drug
dmat2d = ODORtrials.(chan_names{ch2}){2};
[C_ODORs,ph,s12,s1_ODORs,s2_ODORs,f,confc,phie,cerr]=coherencyc(dmat1s,dmat2s,params);
[C_ODORd,ph,s12,s1_ODORd,s2_ODORd,f,confc,phie,cerr]=coherencyc(dmat1d,dmat2d,params);

% ch1 power
titles = odor_names;
ind = 1;
figure
set(gcf,'position',[100,100,500,450])
for ii = 1:no
    if exist('intrep','var')
        trial_inds = [];
        for jj = 1:intrep
            % interleaved (pres intrep times)
            trial_inds = [trial_inds, jj:2*intrep:no*nt];
        end
        trial_inds = sort(trial_inds)+(intrep*(ii-1));
    else
        trial_inds = ((ii-1)*nt+1+skipt):ii*nt;
    end
    if usebl == 1
        pwrs = s1_ODORs(:,trial_inds) ./ repmat(s1_First5ms_ave,nt-skipt,1)';
        pwrd = s1_ODORd(:,trial_inds) ./ repmat(s1_First5md_ave,nt-skipt,1)';
%         pwrs = log(s1_ODORs(:,trial_inds)) ./ repmat(log(s1_First5ms_ave),nt,1)';
%         pwrd = log(s1_ODORd(:,trial_inds)) ./ repmat(log(s1_First5md_ave),nt,1)';
    else
        pwrs = log(s1_ODORs(:,trial_inds));
        pwrd = log(s1_ODORd(:,trial_inds));
    end
    subplot(no,1,ii)
    H1=shadedErrorBar(f,mean(pwrs,2),std(pwrs,0,2),'b');
    %H1=shadedErrorBar(f,median(pwrs,2),mad(pwrs,1,2),'b');
    ylim(YLp);title(titles{ii})
    hold on
    H2=shadedErrorBar(f,mean(pwrd,2),std(pwrd,0,2),'r',0.1);
    %H2=shadedErrorBar(f,median(pwrd,2),mad(pwrd,1,2),'r',0.1);
    if usebl == 1
        plot(f,ones(length(f),1),'k--','linewidth',2)
    end
    ind = ind+1;
    set(gca,'fontsize',14)
    if ii == 1
        legend([H1.mainLine H2.mainLine],'Saline',drug_name,'location','northeast')
    end
    ylabel(ylabp)
    xlim(XL)
end
xlabel('Frequency (Hz)')
suptitle(['Odor session ',chan_names{ch1},' power'])
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'_Power_',Ssess,'&',Dsess,'_','O.tif'];
    saveas(gcf,fname)
end

% ch2 power
titles = odor_names;
figure
set(gcf,'position',[100,100,500,450])
for ii = 1:no
    if exist('intrep','var')
        trial_inds = [];
        for jj = 1:intrep
            % interleaved (pres intrep times)
            trial_inds = [trial_inds, jj:2*intrep:no*nt];
        end
        trial_inds = sort(trial_inds)+(intrep*(ii-1));
    else
        trial_inds = ((ii-1)*nt+1+skipt):ii*nt;
    end
    if usebl == 1
        pwrs = s2_ODORs(:,trial_inds) ./ repmat(s2_First5ms_ave,nt-skipt,1)';
        pwrd = s2_ODORd(:,trial_inds) ./ repmat(s2_First5md_ave,nt-skipt,1)';
 %        pwrs = log(s2_ODORs(:,trial_inds)) ./ repmat(log(s2_First5ms_ave),nt,1)';
 %        pwrd = log(s2_ODORd(:,trial_inds)) ./ repmat(log(s2_First5md_ave),nt,1)';
    else
        pwrs = log(s2_ODORs(:,trial_inds));
        pwrd = log(s2_ODORd(:,trial_inds));
    end
    subplot(no,1,ii)
    H1=shadedErrorBar(f,mean(pwrs,2),std(pwrs,0,2),'b');
    %H1=shadedErrorBar(f,median(pwrs,2),mad(pwrs,1,2),'b');
    ylim(YLp);title(titles{ii})
    hold on
    H2=shadedErrorBar(f,mean(pwrd,2),std(pwrd,0,2),'r',0.1);
    %H2=shadedErrorBar(f,median(pwrd,2),mad(pwrd,1,2),'r',0.1);
    if usebl == 1
        plot(f,ones(length(f),1),'k--','linewidth',2)
    end
    set(gca,'fontsize',14)
    if ii == 1
        legend([H1.mainLine H2.mainLine],'Saline',drug_name,'location','northeast')
    end
    ylabel(ylabp)
    xlim(XL)
end
xlabel('Frequency (Hz)')
suptitle(['Odor session ',chan_names{ch2},' power'])
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch2},'_Power_',Ssess,'&',Dsess,'_','O.tif'];
    saveas(gcf,fname)
end

% Average Coherency
% titles = {'EMB';'Anisol';'Geraniol';'EMB (recovery)'};
% ind = 1;
% figure
% set(gcf,'position',[100,0,600,900])
% for ii = 1:no
%     trial_inds = ((ind-1)*nt+1):ind*nt;
%     subplot(no,1,ii)
%     H1=shadedErrorBar(f,mean(atanh(C_ODORs(:,trial_inds)),2),std(atanh(C_ODORs(:,trial_inds)),0,2),'b');
%     ylim(YLc);title(titles{ii})
%     hold on
%     H2=shadedErrorBar(f,mean(atanh(C_ODORd(:,trial_inds)),2),std(atanh(C_ODORd(:,trial_inds)),0,2),'r',0.1);
%     ind = ind+1;
%     if ii == 1
%         legend([H1.mainLine H2.mainLine],'Saline',drug_name,'location','northeast')
%     end
%     ylabel('Coh')
%     xlim(XL)
% end
% xlabel('Frequency (Hz)')
% suptitle(['Odor session ',chan_names{ch1},'-',chan_names{ch2},' atanh(coherency)'])
% if sff == 1
%     fname = [Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Coh_',Ssess,'&',Dsess,'_','O.tif'];
%     saveas(gcf,fname)
% end
% 
