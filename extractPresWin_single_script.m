%% Extract presentation windows for single data file

% initialize data structures
for ch = usechan
    if nb > 0
        BLANKtrials.(chan_names{ch}) = [];
    end
    ODORtrials.(chan_names{ch}) = [];
end


skipdp = ceil(5.6*sf); % # of data points to skip durring dtrig scan
% must be 5.6s instead of 6s to accommodate the two asshole close trials from
% RK88 Oxorev1... fml

    if nb > 0
        blank_inds = scandtrig(blank_trig,skipdp,nb*nt);
        % NOTE trialalign requires input data vector to be dim ndp x 1
        for ch = usechan
            BLANKtrials.(chan_names{ch}) = trialalign(Vdata(ch,:),blank_inds,pre,post,sf);
            ODORtrials.(chan_names{ch}) = trialalign(Vdata(ch,:),odor_inds,pre,post,sf);
        end
    end
    
    odor_inds = scandtrig(odor_trig,skipdp,no*nt);
    for ch = usechan
        ODORtrials.(chan_names{ch}) = trialalign(Vdata(ch,:),odor_inds,pre,post,sf);
    end


twin = -pre:1/sf:post; % time window (s)

% detrend trials and remove movement artefact

    for ch = usechan
        if nb > 0
        for tt = 1:nb*nt
            BLANKtrials.(chan_names{ch})(:,tt) = detrend(BLANKtrials.(chan_names{ch})(:,tt));
        end
        end
        for tt = 1:no*nt
            ODORtrials.(chan_names{ch})(:,tt) = detrend(ODORtrials.(chan_names{ch})(:,tt));
        end
        
        if maf(ch) == 1
            if nb > 0
            for tt = 1:nb*nt
                filt_temp = filtfilt(lpFilt,BLANKtrials.(chan_names{ch})(:,tt));
                BLANKtrials.(chan_names{ch})(:,tt) = BLANKtrials.(chan_names{ch})(:,tt) - filt_temp;
            end
            end
            for tt = 1:no*nt
                filt_temp = filtfilt(lpFilt,ODORtrials.(chan_names{ch})(:,tt));
                ODORtrials.(chan_names{ch})(:,tt) = ODORtrials.(chan_names{ch})(:,tt) - filt_temp;
            end
        end
    end

