% Calculate baseline LFP power for saline-drug pair data
% compare first 5min and last min spectra

% perform on a single channel.

% First 5min
dmats = detrend(First5m.(chan_names{ch}){1})'; % s - Saline
dmatd = detrend(First5m.(chan_names{ch}){2})'; % d - Drug


[~,~,~,S_First5ms,S_First5md,ts,f]=cohgramc(dmats,dmatd,movingwin,params);
% NOTE I just use cohgram here because it has a moving window option. This
% should really be the spectrogram function... meh too lazy
td = ts; % % For cases where noisy/tremmor data is removed the total time may not be the
% same for saline and drug data, so we keep ts and td as seperate time
% markers
if exist('bad_First5ms','var')
    S_First5ms(bad_First5ms,:) = [];
    ts(bad_First5ms) = [];
end
S_First5ms_ave = mean(S_First5ms);

if exist('bad_First5md','var')
    S_First5md(bad_First5md,:) = [];
    td(bad_First5md) = [];
end
S_First5md_ave = mean(S_First5md);



% Last 5min
% not needed