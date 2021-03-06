function [meanmaxpwr, meanstdpwr, medianmaxpwr, medianstdpwr, MaxPwrMAT] = ...
    GetPeakPWR_normsal(dmat,fqr,no,nt,skipt,params,usebl,baseline_pwrs,baseline_pwrd,normsal,dsal)

% This function calculates peak power in beta and high/low gamma bands for a
% single data set.

% MUST INCLUDE SEPERATE BASELINES FOR SAL AND DRUG!!!

% It also normalizes by median of saline data if normsal = 1

% usebl and normsal are both flags (0 or 1)

% Output is size(ff) x no x S or D : usually 3x2x2



% calculate mtfft power
N = size(dmat,1); % number of samples
[tapers,pad,Fs,fpass,~,~]=getparams(params);
nfft=max(2^(nextpow2(N)+pad),N);
[f,findx]=getfgrid(Fs,nfft,fpass);
tapers=dpsschk(tapers,N,Fs); % check tapers
Js=mtfftc(dsal,tapers,nfft,Fs); % calculate mtfft on saline data
Js=Js(findx,:,:);
Ss=squeeze(mean(conj(Js).*Js,2));
Jd=mtfftc(dmat,tapers,nfft,Fs); % calculate mtfft on drug data
Jd=Jd(findx,:,:);
Sd=squeeze(mean(conj(Jd).*Jd,2));


%saline
meanmaxpwr = zeros(size(fqr,1),no,2); % number of fq-bands by no
meanstdpwr = zeros(size(fqr,1),no,2);
medianmaxpwr = zeros(size(fqr,1),no,2); % number of fq-bands by no
medianstdpwr = zeros(size(fqr,1),no,2);
% 3rd dim is sal/drug

% This will store max pwr for all trials (used for ANOVA)
MaxPwrMAT = cell(2,1); % cell is over Sal/Drug
% each element will have dim #trials(24) x #fqbands(3) x #odors(2)

maxpawrs_tr = zeros(nt-skipt,size(fqr,1),no); % save saline trials
maxpawrd_tr = zeros(nt-skipt,size(fqr,1),no); % save drug trials

for ff = 1:size(fqr,1)
f1ind = find(f<fqr(ff,1),1,'last');
f2ind = find(f>fqr(ff,2),1,'first');
for ii = 1:no
    trial_inds = ((ii-1)*nt+1+skipt):ii*nt;
    % normalize by baseline
    if usebl == 1
        pwrs = Ss(:,trial_inds) ./ repmat(baseline_pwrs,nt-skipt,1)';
        pwrd = Sd(:,trial_inds) ./ repmat(baseline_pwrd,nt-skipt,1)';
    else
        pwrs = log(Ss(:,trial_inds));
        pwrd = log(Sd(:,trial_inds));
    end
    
    % normalize by median saline (only applied to drug data)
    if normsal == 1
        mediansalpwr = median(pwrs');
        pwrd = pwrd ./ repmat(mediansalpwr,nt-skipt,1)';
    end
    
    maxpwrs = max(pwrs(f1ind:f2ind,:));
    maxpwrd = max(pwrd(f1ind:f2ind,:));
    
    maxpawrs_tr(:,ff,ii) = maxpwrs;
    maxpawrd_tr(:,ff,ii) = maxpwrd;
    
    % first take max, then mean (or median)
    %saline
     meanmaxpwr(ff,ii,1) = mean(maxpwrs);
     meanstdpwr(ff,ii,1) = std(maxpwrs);
     medianmaxpwr(ff,ii,1) = median(maxpwrs);
     medianstdpwr(ff,ii,1) = mad(maxpwrs,1);
    %drug
     meanmaxpwr(ff,ii,2) = mean(maxpwrd);
     meanstdpwr(ff,ii,2) = std(maxpwrd);
     medianmaxpwr(ff,ii,2) = median(maxpwrd);
     medianstdpwr(ff,ii,2) = mad(maxpwrd,1);

end
end

MaxPwrMAT{1} = maxpawrs_tr;
MaxPwrMAT{2} = maxpawrd_tr;