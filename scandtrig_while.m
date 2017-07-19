function tinds = scandtrig_while(dtrig,skipdp)

% Unfortunately, the TTL button presses sometimes briefly interrupt
% within a single press, resulting in multiple TTL pulses within one button press

% This function scans dtrig to find onsets of button pres and then skips a 
% time skipt and starts scanning again until ntrig triggers have been detected

% NOTE: This function is meant to analyze MCrack digital triger (dtrig) data

% NOTE: All this would be totally unnecessary if the pulses were pefect
% squarewaves since that would simply require finding the points where
% diff(dtrig(2:end)) = 1. But alas, life is stupid sometimes.

% Boleszek Osinski (2015)
% Kay Lab

%%%%%%%%%%%%
% INPUTS   %
%%%%%%%%%%%%
% dtrig  - digital (binary) trigger values
% skipdp - # of data points to skip after detecting onset of button press (to avoid
%           detecting transient triggers within a single button press)

%%%%%%%%%%%
% OUTPUT  %
%%%%%%%%%%%
% tinds    - triger pulse onset indices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tinds = zeros(nt,1);

    % scan across the data. find all the onsets of TTL pulse (represented by 1)
    
tinds = find(dtrig == 1, 1, 'first'); % previous ind will update each time new pulse is detected
prev_ind = tinds;
num = tinds;
ii = 1;
while ~isempty(num)
    prev_ind = tinds(ii);
    % start scan skip s after prev_ind to avoid finding button press transients
    num = find(dtrig(prev_ind+skipdp:end) == 1, 1, 'first') + prev_ind + skipdp;
    tinds = [tinds;num];
    ii = ii+1;
end

