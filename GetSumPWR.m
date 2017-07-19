function [meansumpwr, meanstdpwr, mediansumpwr, medianstdpwr] = GetSumPWR(dmat,fqr,no,nt,skipt,params,usebl,baseline_pwr)

% This function calculates peak power in beta and high/low gamma bands for a
% single data set.

% Output is size(ff)xno : usually 3x2

if nargin < 8
    baseline_pwr = [];
end



% calculate mtfft power
N = size(dmat,1); % number of samples
[tapers,pad,Fs,fpass,~,~]=getparams(params);
nfft=max(2^(nextpow2(N)+pad),N);
[f,findx]=getfgrid(Fs,nfft,fpass);
tapers=dpsschk(tapers,N,Fs); % check tapers
J=mtfftc(dmat,tapers,nfft,Fs);
J=J(findx,:,:);
S=squeeze(mean(conj(J).*J,2));


meansumpwr = zeros(size(fqr,1),no); % number of fq-bands by no
meanstdpwr = zeros(size(fqr,1),no);
mediansumpwr = zeros(size(fqr,1),no); % number of fq-bands by no
medianstdpwr = zeros(size(fqr,1),no);
for ff = 1:size(fqr,1)
ind = 1;
f1ind = find(f<fqr(ff,1),1,'last');
f2ind = find(f>fqr(ff,2),1,'first');
for ii = 1:no
    trial_inds = ((ind-1)*nt+1+skipt):ind*nt;
    if usebl == 1
        pwr = S(:,trial_inds) ./ repmat(baseline_pwr,nt-skipt,1)';
    else
        pwr = log(S(:,trial_inds));
    end
    
    % first take max, then mean
     meansumpwr(ff,ii) = mean(sum(pwr(f1ind:f2ind,:))/numel(f1ind:f2ind));
     meanstdpwr(ff,ii) = std(sum(pwr(f1ind:f2ind,:))/numel(f1ind:f2ind));
     mediansumpwr(ff,ii) = median(sum(pwr(f1ind:f2ind,:))/numel(f1ind:f2ind));
     medianstdpwr(ff,ii) = mad(sum(pwr(f1ind:f2ind,:))/numel(f1ind:f2ind),1);
    
     % first take mean, then max
%      [maxpwr(ff,ii), max_ind] = max(mean(pwr(f1ind:f2ind,:),2));
%      std_vec = std(pwr(f1ind:f2ind,:),0,2);
%      stdpwr(ff,ii) = std_vec(max_ind);
     
    ind = ind+1;
end
end