%% Extract first and last 5min periods for salin-drug pair data

% initialize data structures
for ch = usechan
    First5m.(chan_names{ch}) = cell(2,1);
    Last5m.(chan_names{ch}) = cell(2,1);
end


for ii = 1:2
    for ch = usechan
        First5m.(chan_names{ch}){ii} = Vdata{ii}(ch,(1:tb*60*sf)+30*sf); % skip first 30s at start of aquisition to avoid transients
        Last5m.(chan_names{ch}){ii} = Vdata{ii}(ch,(1+end-tb*60*sf):end);
    end
end



% remove movement artefact (< 4 Hz)
if maf5 == 1
% NOTE: This takes ~5min to evaluate!!!
for ii = 1:2
    for ch = usechan
        filt_temp = filtfilt(lpFilt,First5m.(chan_names{ch}){ii});     
        First5m.(chan_names{ch}){ii} = First5m.(chan_names{ch}){ii} - filt_temp;
        filt_temp = filtfilt(lpFilt,Last5m.(chan_names{ch}){ii});     
        Last5m.(chan_names{ch}){ii} = Last5m.(chan_names{ch}){ii} - filt_temp;
    end
end
end