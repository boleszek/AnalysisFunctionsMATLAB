function normPWR = NormalizedPWR(base,trials,Fs)
% This function calculates power of baseline period and trials. Then it
% normalizes trial power by baseline

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS:
% base    - baseline recording (usually 1 min recorded before trials)
% trials  - trials of experiemnt (dim samp X trials)
%
% OUTPUTS:
% normPWR - normalized power of trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define parameters
% (if already defined outside of function the comment this out)

% params.tapers = [5 9]; % [thbw ntapers]
% params.pad = 0; % zero padding
% params.Fs = sf; % sampling fq
% params.fpass = [1 120]; % fq range
% params.err = [2 1]; % error codes
% params.trialave = 0; % average over trials? yes(1) no(0)

movingwin = [size(trials,1) size(trials,1)]/Fs; % in (s)
% movingwin is used to divide the baseline period into non-overlaping windows each
% with length equal to trial length

%% Calculate baseline PWR
[C_First5ms,ph,s12,s1_First5ms,s2_First5ms,ts,f]=cohgramc(dmat1s,dmat2s,movingwin,params);
