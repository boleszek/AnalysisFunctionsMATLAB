function NormalizedPWR(base,trials)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS:
% base    - baseline recording (usually 1 min recorded before trials)
% trials  - trials of experiemnt (dim samp X trials)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define parameters (if already defined outside of function the comment
% this out)
% params.tapers = [5 9]; % [thbw ntapers]
% params.pad = 0; % zero padding
% params.Fs = sf; % sampling fq
% params.fpass = [1 120]; % fq range
% params.err = [2 1]; % error codes
% params.trialave = 0; % average over trials? yes(1) no(0)
