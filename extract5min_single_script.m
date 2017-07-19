%% Extract first and last 5min periods for single data file

% initialize data structures
for ch = usechan
    First5m.(chan_names{ch}) = [];
    Last5m.(chan_names{ch}) = [];
end


    for ch = usechan
        First5m.(chan_names{ch}) = Vdata(ch,(1:tb*60*sf)+30*sf); % skip first 30s at start of aquisition to avoid transients
        Last5m.(chan_names{ch}) = Vdata(ch,(1+end-tb*60*sf):end);
    end



% remove movement artefact (< 4 Hz)
if maf5 == 1
% NOTE: This takes ~5min to evaluate!!!
    for ch = usechan
        filt_temp = filtfilt(lpFilt,First5m.(chan_names{ch}));     
        First5m.(chan_names{ch}) = First5m.(chan_names{ch}) - filt_temp;
        filt_temp = filtfilt(lpFilt,Last5m.(chan_names{ch}));     
        Last5m.(chan_names{ch}) = Last5m.(chan_names{ch}) - filt_temp;
    end
end