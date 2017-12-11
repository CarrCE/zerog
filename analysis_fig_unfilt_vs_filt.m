% analysis_fig_unfilt_vs_filt.m

% Filename for this figure
fn = 'analysis_fig_unfilt_vs_filt';
% Plot Limits
ylim = [-1 2.5];
xlim = [0 max(t)];

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

% Unfiltered
subplot(2,1,1);
h = plot(t,g_x,'linewidth',lw); hold on;
h = plot(t,g_y,'linewidth',lw); 
h = plot(t,g_z,'linewidth',lw);
xlabel('Time (s)');
ylabel('G level');
set(gca,'ylim',ylim,'xlim',xlim);
legend('X','Y','Z','Location','eastoutside')

% Filtered
subplot(2,1,2);  
plot(t,g_x_filt,'linewidth',lw); hold on;
plot(t,g_y_filt,'linewidth',lw);
plot(t,g_z_filt,'linewidth',lw);
xlabel('Time (s)');
ylabel('G_{filt}');
set(gca,'ylim',ylim,'xlim',xlim);
legend('X','Y','Z','Location','eastoutside')

% Print
fig.PaperUnits = 'inches'; w = 8; h = 5;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});
