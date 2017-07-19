% Calculate baseline LFP power for single data file
% compare first 5min and last min spectra

% First 5min
dmat = detrend(First5m.(chan_names{ch}))';

[C_First5ms,ph,s12,S_First5ms,S_First5ms,t,f]=cohgramc(dmat,dmat,movingwin,params);
% NOTE I just use cohgram here because it has a moving window option. This
% should really be the spectrogram function... meh too lazy

if exist('bad_First5ms','var')
    S_First5ms(bad_First5ms,:) = [];
    t(bad_First5ms) = [];
end
S_First5ms_ave = mean(S_First5ms);


% Last 5min
dmat = detrend(Last5m.(chan_names{ch}))';

[C_Last5ms,ph,s12,S_Last5ms,S_Last5ms,t,f]=cohgramc(dmat,dmat,movingwin,params);
S_Last5ms_ave = mean(S_Last5ms);

% I don't extract bad data from last 5 min, so I use just t for both drug and
% saline data


if pplot == 1
    YLpp = [0 12];
    figure
    plot(f,log(S_First5ms_ave),f,log(S_Last5ms_ave))
    legend('First 5min','Last 5min')
    ylim(YLpp);ylabel('log(power)')
    xlabel('Fq (Hz)')
    title([ chan_names{ch}]);
%     if sff == 1
%         fname = [Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Power_',Ssess,'&',Dsess,'_','FirstLast5min.tif'];
%         saveas(gcf,fname)
%     end
end


if splot == 1
% View spectrograms
yheight = [0 100];
ca = [0 9];

% Saline
figure
set(gcf,'position',[100,100,1000,700])
pcolor(t,f,log(S_First5ms)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch}]);
ylabel('fq (Hz)');

% if sff == 1
%     fname = [Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Spectrogram_',Ssess,'_','FirstLast5min.tif'];
%     saveas(gcf,fname)
% end
end
