function ALIGNED_DATA = trialalign(DATA,tp,pre,post,sf)

% trialalign - Extracts windows of DATA around event times defined by tp.
% Window size is defined by pre & post
%
% Boleszek Osinski (2015)
% Kay Lab at the University of Chicago
%
%%% INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DATA - 1D vector of data points (dim ndp x 1)
% tp   - 1D vector of event time points
% pre  - edge of time window before event time (s)
% post - edge of time window after event time (s)
% sf   - sampling frequency (Hz)
%
%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ALIGNED_DATA - Matrix of data windows aligned to event times. Dimensions
% wind len X num trials
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nt = length(tp);
window = (-sf*pre:sf*post);
lt = length(window);


ALIGNED_DATA = zeros(lt,nt);
for ii = 1:nt
    if tp(ii) == 0
        % tp = 0 means this trigger does not exist
        ALIGNED_DATA(:,ii) = zeros(lt,1);
    else
%     start_ind = ceil(tp(ii) - pre*sf);
%     end_ind = floor(tp(ii)  + post*sf);
%     DATA_temp = DATA(start_ind:end_ind);
        start_ind = ceil(tp(ii));
        DATA_temp = DATA(start_ind+window);
    if size(DATA_temp,1) == 1
        DATA_temp = DATA_temp';
    end
    ALIGNED_DATA(:,ii) = DATA_temp;
    end
end
