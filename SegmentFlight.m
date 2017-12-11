% SEGMENTFLIGHT segments a parabolic flight trajectory g-level profile
% by identifying mean g-level change points and their associated
% transition points, corresponding to discontinuities in the slope
% of the g-level vs. time curve. Change points correspond to points
% between regions of different mean g-levels, e.g. these points are
% found within periods of transition. Transition points identify
% the boundaries of these transition periods. 
%
% [cp,tp] = SEGMENTFLIGHT(G,N,Fs) returns the change points CP and 
% transition points TP for the G-level profile in vector G. CP and TP are 
% indexes into G. N is the number of change points to identify. Fs is the
% sample frequency of G.
%
% [cp,tp] = SEGMENTFLIGHT(G,N,Fs,T) searches for transition points using at
% most T seconds of data on each side of each change point, determined 
% using the sample rate Fs. By default, T=10 seconds.
%
% N should be equal to the number of parabolas x 2, plus 2 times the number
% of sets of parabolas (each set has an extra entry and exit).
%
% Example:
%
% A flight has four sets of parabolas with 5, 6, 4, and 5 parabolas:
%
%   5 parabolas: 5*2 + 2 = 12 change points
%   6 parabolas: 6*2 + 2 = 14 change points
%   4 parabolas: 4*2 + 2 = 10 change points
%   5 parabolas: 5*2 + 2 = 12 change points
%   Total:                 48 change points
%
% Use N=48.
%
% Author: Christopher E. Carr
% chrisc at mit dot edu
% 2017/11/28
%
function [cp,tp]=SegmentFlight(g,N,Fs,T)
    if nargin<4, T = 10; end    
    if nargin<3, error('SegmentFlight: not enough arguments'); end
    
    %Find the change points
    cp = findchangepts(g,'Statistic','mean','MaxNumChanges',N);

    % Find the transitions around each change point within T_t seconds
    tp = NaN(2,N);
    for k=1:N
        % Find indices corresponding to transition time
        % e.g. within T seconds of change point
        cp_range = cp(k) + round(double(Fs*T)) * [-1 1];
        % Get data for this interval
        g_trans = g(cp_range(1):cp_range(2));
        % Get linear changepoints
        cp_trans = findchangepts(g_trans,'Statistic','linear','MaxNumChanges',2);
        % Adjust transition points to get absolute index
        cp_trans_adj = cp_trans + cp_range(1) - 1;
        % store transition points
        tp(:,k) = cp_trans_adj';
    end
end