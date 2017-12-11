% analysis_fig_filt_good_vs_bad.m

% Filename for this figure
fn = 'analysis_fig_filt_good_vs_bad';

% Plot limits
ylim = [-0.1 2];    
% xlim = [1320 1370]; % Lunar g parabola
% xlim = [1400 1450]; % 1st 0 g parabola
xlim = [1475 1520]; % 2nd 0 g parabola

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

% Compare Filtered vs. Unfiltered for 2 Half-Power Frequencies (HPFs)

% Design filter with 10X lower HPF
% Design the filter
HPF_bad = HPF/10;
d1_bad = designfilt(FilterOptions{:},'HalfPowerFrequency',HPF_bad);
% Do the filtering
g_x_filt_bad = filtfilt(d1_bad,g_x);
g_y_filt_bad = filtfilt(d1_bad,g_y);
g_z_filt_bad = filtfilt(d1_bad,g_z);
% Recompute g_filt_bad
g_filt_bad = sqrt(g_x_filt_bad.^2 + g_y_filt_bad.^2 + g_z_filt_bad.^2);

% Plot
subplot(2,2,[1 2]);
h = plot(t,g,'linewidth',lw); hold on; h.Color(4) = 1;
plot(t,g_filt_bad,'linewidth',lw*1.5); hold on;
plot(t,g_filt,'linewidth',lw*1.5); hold on;
xlabel('Time (s)');
ylabel('G level');
legend('Unfiltered',sprintf('HPF=%0.3fHz',HPF_bad),sprintf('HPF=%0.3fHz',HPF),'Location','North');
set(gca,'ylim',ylim,'xlim',xlim);

% Plot
subplot(2,2,3);
h = plot(t,g,'linewidth',lw); hold on; h.Color(4) = 1;
plot(t,g_filt_bad,'linewidth',lw*1.5); hold on;
plot(t,g_filt,'linewidth',lw*1.5); hold on;
xlabel('Time (s)');
ylabel('G level');
set(gca,'ylim',ylim,'xlim',[1480 1490]);
%legend('Unfiltered',sprintf('HPF=%0.3fHz',HPF_bad),sprintf('HPF=%0.3fHz',HPF));

% Plot
subplot(2,2,4);
h = plot(t,g,'linewidth',lw); hold on; h.Color(4) = 1;
plot(t,g_filt_bad,'linewidth',lw*1.5); hold on;
plot(t,g_filt,'linewidth',lw*1.5); hold on;
xlabel('Time (s)');
ylabel('G level');
set(gca,'ylim',ylim,'xlim',[1504 1514]);
%legend('Unfiltered',sprintf('HPF=%0.3fHz',HPF_bad),sprintf('HPF=%0.3fHz',HPF));

% Print
fig.PaperUnits = 'inches'; w = 8; h = 4;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});
