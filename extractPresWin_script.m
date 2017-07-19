%% Extract presentation windows for saline-drug pairs


if nb > 0
    blank_inds = zeros(nb*nt,2);
end
odor_inds = zeros(no*nt,2);
%%%% Note!!!!!!: The 1st row is Saline data, 2nd row is drug data

% initialize data structures
for ch = usechan
    if nb > 0
        BLANKtrials.(chan_names{ch}) = cell(2,1);
    end
    ODORtrials.(chan_names{ch}) = cell(2,1);
end
%%%% Note!!!!!!: The 1st cell is Saline data, 2nd cell is drug data



skipdp = ceil(5.6*sf); % # of data points to skip durring dtrig scan
% must use 5.6s instead of 6s because of the one goulash oxo sess :-/

for ii = 1:2
    if nb > 0
        blank_inds(:,ii) = scandtrig(blank_trig{ii},skipdp,nb*nt);
        % NOTE trialalign requires input data vector to be dim ndp x 1
        for ch = usechan
            BLANKtrials.(chan_names{ch}){ii} = trialalign(Vdata{ii}(ch,:),blank_inds(:,ii),pre,post,sf);
        end
    end
    
    if exist('delete_trials','var')
        ndt = length(delete_trials{ii});
        odor_inds_temp = scandtrig(odor_trig{ii},skipdp,no*nt+ndt);
        odor_inds_temp(delete_trials{ii}) = [];% delete extra trials
        odor_inds(:,ii) = odor_inds_temp;
    else
        odor_inds(:,ii) = scandtrig(odor_trig{ii},skipdp,no*nt);
    end
    
    for ch = usechan
        ODORtrials.(chan_names{ch}){ii} = trialalign(Vdata{ii}(ch,:),odor_inds(:,ii),pre,post,sf);
    end
end

twin = -pre:1/sf:post; % time window (s)

% detrend trials and remove movement artefact
for ii = 1:2
    for ch = usechan
        if nb > 0
        for tt = 1:nb*nt
            BLANKtrials.(chan_names{ch}){ii}(:,tt) = detrend(BLANKtrials.(chan_names{ch}){ii}(:,tt));
        end
        end
        for tt = 1:no*nt
            ODORtrials.(chan_names{ch}){ii}(:,tt) = detrend(ODORtrials.(chan_names{ch}){ii}(:,tt));
        end
        
        if maf(ch) == 1
            if nb > 0
            for tt = 1:nb*nt
                filt_temp = filtfilt(lpFilt,BLANKtrials.(chan_names{ch}){ii}(:,tt));
                BLANKtrials.(chan_names{ch}){ii}(:,tt) = BLANKtrials.(chan_names{ch}){ii}(:,tt) - filt_temp;
            end
            end
            for tt = 1:no*nt
                filt_temp = filtfilt(lpFilt,ODORtrials.(chan_names{ch}){ii}(:,tt));
                ODORtrials.(chan_names{ch}){ii}(:,tt) = ODORtrials.(chan_names{ch}){ii}(:,tt) - filt_temp;
            end
        end
    end
end

