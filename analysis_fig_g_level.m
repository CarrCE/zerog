% analysis_fig_g_level.m
%
% Plot g-level (norm of g vector) to check for good calibration
%

% Filename for this figure
fn = 'analysis_fig_g_level';

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

subplot(3,1,1);
plot(t,g);
xlabel('Time (s)');
ylabel('G level');

subplot(3,1,2);
plot(t,g_filt);
xlabel('Time (s)');
ylabel('G_{Filt}');

subplot(3,1,3);
plot(t,g_filt-g_z_filt);
xlabel('Time (s)');
ylabel('G_{Filt} - G_{z_{Filt}}');
set(gca,'ylim',[-0.05 0.15]);

% Print
fig.PaperUnits = 'inches'; w = 8; h = 8;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});

