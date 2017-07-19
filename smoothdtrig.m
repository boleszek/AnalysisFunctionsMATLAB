function dtrig_ma_th = smoothdtrig(dtrig)

% Unfortunately, the TTL button presses sometimes briefly interrupt
% within a single press, resulting in multiple TTL pulses within one button press

% This function takes a MOVING AVERAGE of the TTL pules, then thresholds,
% to recover the button press period to within accuracy of a few 10s of ms

% NOTE: This function is meant to analyze MCrack digital triger (dtrig) data

% NOTE: All this would be totally unnecessary if the pulses were pefect
% squarewaves since that would simply require finding the points where
% diff(dtrig(2:end)) = 1. But alas, life is stupid sometimes.

% Boleszek Osinski (2015)
% Kay Lab

%%%%%%%%%%%%
% INPUTS   %
%%%%%%%%%%%%
% dtrig       - digital (binary) trigger values (noisy)

%%%%%%%%%%%
% OUTPUT  %
%%%%%%%%%%%
% dtrig_ma_th  - smoothed binary trigger values (clean)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% first take moving average of dtrig
span = 31;
dtrig_ma = smooth(double(dtrig),span,'moving');
% I find that 31 is a good span for the moving average

% Then threshold dtrig_ma so that it is binary
dtrig_ma_th = dtrig_ma > 0.2; % threshold of 0.2 looks good
% this has effect of shifting onset/ofset to later times. Shift back by
% span/5 to acheive closer alignment

span5 = floor(span/5); % 1/5 of span
dtrig_ma_th = [dtrig_ma_th(span5+1:end); zeros(span5,1)];


% % plots for visualizing (odor_trig must be loaded from somewhere else)
% hold on
% plot(1000*(1:length(odor_trig))/sf,odor_trig)
% plot(1000*(1:length(odor_trig))/sf,dtrig_ma)
% plot(1000*(1:length(odor_trig))/sf,dtrig_ma_th)
% xlabel('Time (ms)','fontsize',14);legend('dtrig','moving ave','thresh')
