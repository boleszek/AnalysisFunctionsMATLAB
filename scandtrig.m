function tinds = scandtrig(dtrig,skipdp,nt)

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
% nt     - number of trigers to scan

%%%%%%%%%%%
% OUTPUT  %
%%%%%%%%%%%
% tinds    - triger pulse onset indices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tinds = zeros(nt,1);

    % scan across the data. find all the onsets of TTL pulse (represented by 1)
    
     tinds(1) = find(dtrig == 1, 1, 'first'); % previous ind will update each time new pulse is detected
     prev_ind = tinds(1);
    for ii = 2:nt
        % start scan skip s after prev_ind to avoid finding button press transients
        num = find(dtrig(prev_ind+skipdp:end) == 1, 1, 'first') + prev_ind + skipdp;
        % in case of extra trials (ntrig > actual # trials) set extra 
        % trials equal to a 0 vector
        if isempty(num)
            tinds(ii) = 0;
        else
        tinds(ii) = num;
        prev_ind = tinds(ii);
        end
    end

