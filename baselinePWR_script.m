% Calculate baseline LFP power for saline-drug pair data
% compare first 5min and last min spectra

% First 5min
dmat1s = detrend(First5m.(chan_names{ch1}){1})'; % s - Saline
dmat2s = detrend(First5m.(chan_names{ch2}){1})';
dmat1d = detrend(First5m.(chan_names{ch1}){2})'; % d - Drug
dmat2d = detrend(First5m.(chan_names{ch2}){2})';

[C_First5ms,ph,s12,s1_First5ms,s2_First5ms,ts,f]=cohgramc(dmat1s,dmat2s,movingwin,params);
[C_First5md,ph,s12,s1_First5md,s2_First5md,td,f]=cohgramc(dmat1d,dmat2d,movingwin,params);
if exist('bad_First5ms','var')
    s1_First5ms(bad_First5ms,:) = [];
    s2_First5ms(bad_First5ms,:) = [];
    ts(bad_First5ms) = [];
end
s1_First5ms_ave = mean(s1_First5ms);
s2_First5ms_ave = mean(s2_First5ms);
if exist('bad_First5md','var')
    s1_First5md(bad_First5md,:) = [];
    s2_First5md(bad_First5md,:) = [];
    td(bad_First5md) = [];
end
s1_First5md_ave = mean(s1_First5md);
s2_First5md_ave = mean(s2_First5md);

% For cases where noisy/tremmor data is removed the total time may not be the
% same for saline and drug data, so we keep ts and td as seperate time
% markers

% Last 5min
dmat1s = detrend(Last5m.(chan_names{ch1}){1})'; % s - Saline
dmat2s = detrend(Last5m.(chan_names{ch2}){1})';
dmat1d = detrend(Last5m.(chan_names{ch1}){2})'; % d - Drug
dmat2d = detrend(Last5m.(chan_names{ch2}){2})';

[C_Last5ms,ph,s12,s1_Last5ms,s2_Last5ms,t,f]=cohgramc(dmat1s,dmat2s,movingwin,params);
[C_Last5md,ph,s12,s1_Last5md,s2_Last5md,t,f]=cohgramc(dmat1d,dmat2d,movingwin,params);
s1_Last5ms_ave = mean(s1_Last5ms);
s2_Last5ms_ave = mean(s2_Last5ms);
s1_Last5md_ave = mean(s1_Last5md);
s2_Last5md_ave = mean(s2_Last5md);

% I don't extract bad data from last 5 min, so I use just t for both drug and
% saline data


if pplot == 1
    YLpp = [0 12];
    figure
    subplot(2,2,1)
    plot(f,log(s1_First5ms_ave),f,log(s1_Last5ms_ave))
    legend('First 5min','Last 5min')
    ylim(YLpp);ylabel('log(power)')
    xlim(XL);xlabel('Fq (Hz)')
    title([ chan_names{ch1} ' Saline ']);
    subplot(2,2,3)
    plot(f,log(s2_First5ms_ave),f,log(s2_Last5ms_ave))
    legend('First 5min','Last 5min')
    ylim(YLpp);ylabel('log(power)')
    xlim(XL);xlabel('Fq (Hz)')
    title([ chan_names{ch2} ' Saline ']);
    subplot(2,2,2)
    plot(f,log(s1_First5md_ave),f,log(s1_Last5md_ave))
    legend('First 5min','Last 5min')
    ylim(YLpp);ylabel('log(power)')
    xlim(XL);xlabel('Fq (Hz)')
    title([ chan_names{ch1} ' ',drug_name]);
    subplot(2,2,4)
    plot(f,log(s2_First5md_ave),f,log(s2_Last5md_ave))
    legend('First 5min','Last 5min')
    ylim(YLpp);ylabel('log(power)')
    xlim(XL);xlabel('Fq (Hz)')
    title([ chan_names{ch2} ' ',drug_name]);
    if sff == 1
        fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Power_',Ssess,'&',Dsess,'_','FirstLast5min.tif'];
        saveas(gcf,fname)
    end
end


if splot == 1
% View spectrograms
yheight = [0 100];
ca = [0 9];

% Saline
figure
set(gcf,'position',[100,100,1000,700])
% ch1 first 5min
subplot(2,2,1)
pcolor(ts,f,log(s1_First5ms)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch1} ' First 5min ']);
ylabel('fq (Hz)');
% ch1 last 5min
subplot(2,2,2)
pcolor(t,f,log(s1_Last5ms)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch1} ' Last 5min ']);
ylabel('Fq (Hz)');xlabel('Time (s)  ');
% ch2 first 5min
subplot(2,2,3)
pcolor(ts,f,log(s2_First5ms)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch2} ' First 5min ']);
ylabel('fq (Hz)');
% ch2 last 5min
subplot(2,2,4)
pcolor(t,f,log(s2_Last5ms)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch2} ' Last 5min ']);
ylabel('Fq (Hz)');xlabel('Time (s)  ');
suptitle('Saline')
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Spectrogram_',Ssess,'_','FirstLast5min.tif'];
    saveas(gcf,fname)
end

% Drug
figure
set(gcf,'position',[100,100,1000,700])
% ch1 first 5min
subplot(2,2,1)
pcolor(td,f,log(s1_First5md)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch1} ' First 5min ']);
ylabel('fq (Hz)');
% ch1 last 5min
subplot(2,2,2)
pcolor(t,f,log(s1_Last5md)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch1} ' Last 5min ']);
ylabel('Fq (Hz)');xlabel('Time (s)  ');
% ch2 first 5min
subplot(2,2,3)
pcolor(td,f,log(s2_First5md)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch2} ' First 5min ']);
ylabel('fq (Hz)');
% ch2 last 5min
subplot(2,2,4)
pcolor(t,f,log(s2_Last5md)')
shading interp
lighting phong
colorbar
caxis(ca)
set(gca,'fontsize',14)
ylim(yheight)
title([ chan_names{ch2} ' Last 5min ']);
ylabel('Fq (Hz)');xlabel('Time (s)  ');
suptitle(drug_name)
if sff == 1
    fname = ['figs\',Rname,'_',chan_names{ch1},'&',chan_names{ch2},'_Spectrogram_',Dsess,'_','FirstLast5min.tif'];
    saveas(gcf,fname)
end
end
