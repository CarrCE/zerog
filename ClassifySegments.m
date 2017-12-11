% CLASSIFYSEGMENTS classifies periods within a parabolic flight according
% to the change points and transition points identified by SEGMENTFLIGHT.
%
% Each period of the flight is characterized as one of the following:
%   Transition (to/from Parabola)
%   Parabola (reduced gravity simulation)
%   Hypergravity (parabola initiation/recovery only)
%   Other (anything besides Transition or Parabola)
%
% period = ClassifySegment(CP,TP,G) classifies using the default
% classifier options, first denoting periods > 100 seconds as "Other", then
% by mean g-level (estimated from G) as follows:
% -0.1 < mean G level <= 0.9: "Parabola"
%  0.9 < mean G level <= 1.1: "Other"
%  1.1 < mean G level <= +Inf "Hypergravity"
%
% CP and TP are the change points and transition points returned by 
% SEGMENTFLIGHT. G must be a 3 x N matrix of x, y, and z components.
% The mean G-level is computed by first computing the mean of G_x, G_y, and
% G_z, then computing the norm of the means.
%
% period = ClassifySegment(...,C) classifies using custom classifier
% thresholds. For the default classifier, use:
% C = {100, 'Other', {[-0.1 0.9 1.1]}, {'Parabola','Other','Hypogravity'}};
%
% Author: Christopher E. Carr
% chrisc at mit dot edu
% 12/2/2017
%
function period = ClassifySegments(cp,tp,t,g,c)
    % Define the default classifier if necessary
    if nargin<5, c = {100, 'Other', {[-0.1 0.9 1.1]}, ...
            {'Parabola','Other','Hypergravity'}}; end
    
    % Take apart classifier parameter
    classifier_duration = c{1};
    classifier_g_level = c{3};
    classifier_phase = c{4};
    
    % Step through each pair of transition points
    current_index = 1; period = [];
    for k=1:size(tp,2),
        % Identify period from current_index to start of this transition
        p = 2*k-1;
        period(p).period = p;
        period(p).index_start = current_index;
        period(p).index_stop = tp(1,k);
        period(p).N_samples = period(p).index_stop - period(p).index_start + 1;
        period(p).time_start = t(current_index);
        period(p).time_stop = t(tp(1,k));
        period(p).duration_s = period(p).time_stop - period(p).time_start;
        % compute g vector statistics and g-level over the period
        ids = period(p).index_start:period(p).index_stop;
        g_bar = mean(g(:,ids),2);
        g_std = std(g(:,ids),[],2);
        g_bar_norm = norm(g_bar);
        % store results
        period(p).g_bar_norm = g_bar_norm;
        period(p).g_x_bar = g_bar(1);
        period(p).g_y_bar = g_bar(2);
        period(p).g_z_bar = g_bar(3);
        period(p).g_x_std = g_std(1);
        period(p).g_y_std = g_std(2);
        period(p).g_z_std = g_std(3);
        
        % Classify based on duration first, then g-level
        if period(p).duration_s > classifier_duration
            phase = c{2};
        else
            phase = classifier_phase{find(period(p).g_bar_norm>classifier_g_level{:},1,'last')};
        end

        period(p).transition = 0;
        period(p).parabola = strcmpi(phase,'Parabola');
        period(p).hypergravity = strcmpi(phase,'Hypergravity');
        % Identify transition: first transition index to second index
        p = 2*k;
        period(p).period = p;
        period(p).index_start = tp(1,k);
        period(p).index_stop = tp(2,k);
        period(p).N_samples = period(p).index_stop - period(p).index_start + 1;
        period(p).time_start = t(tp(1,k));
        period(p).time_stop = t(tp(2,k));
        period(p).duration_s = period(p).time_stop - period(p).time_start;
        % compute g vector statistics and g-level over the period
        ids = period(p).index_start:period(p).index_stop;
        g_bar = mean(g(:,ids),2);
        g_std = std(g(:,ids),[],2);
        g_bar_norm = norm(g_bar);
        % store results
        period(p).g_bar_norm = g_bar_norm;
        period(p).g_x_bar = g_bar(1);
        period(p).g_y_bar = g_bar(2);
        period(p).g_z_bar = g_bar(3);
        period(p).g_x_std = g_std(1);
        period(p).g_y_std = g_std(2);
        period(p).g_z_std = g_std(3);
        % Classify phase as transition
        period(p).transition = 1;
        period(p).parabola = 0;
        period(p).hypergravity = 0;
        % Move to next transition
        current_index = tp(2,k);
    end
    % Write final period from last transition point to end of data
    p = 2*k+1;
    period(p).period = p;
    period(p).index_start = current_index;
    period(p).index_stop = numel(t); % to last sample
    period(p).N_samples = period(p).index_stop - period(p).index_start + 1;
    period(p).time_start = t(current_index);
    period(p).time_stop = max(t);
    period(p).duration_s = period(p).time_stop - period(p).time_start;
    % compute g vector statistics and g-level over the period
    ids = period(p).index_start:period(p).index_stop;
    g_bar = mean(g(:,ids),2);
    g_std = std(g(:,ids),[],2);
    g_bar_norm = norm(g_bar);
    % store results
    period(p).g_bar_norm = g_bar_norm;
    period(p).g_x_bar = g_bar(1);
    period(p).g_y_bar = g_bar(2);
    period(p).g_z_bar = g_bar(3);
    period(p).g_x_std = g_std(1);
    period(p).g_y_std = g_std(2);
    period(p).g_z_std = g_std(3);
    
    % Classify based on duration, then g-level
    if period(p).duration_s > classifier_duration
        phase = c{2};
    else
        phase = classifier_phase{find(period(p).g_bar_norm>classifier_g_level{:},1,'last')};
    end
    period(p).transition = 0;
    period(p).parabola = strcmpi(phase,'Parabola');
    period(p).hypergravity = strcmpi(phase,'Hypergravity');
end

    