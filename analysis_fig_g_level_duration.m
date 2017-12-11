% analysis_fig_g_level_duration.m
%
% Plot of g-level vs. duration and g-level histogram
%

% Filename for this figure
fn = 'analysis_fig_g_level_duration';

% Identify subsets to plot
bTrans = boolean(periods_table.transition);
bPara = boolean(periods_table.parabola);
bHyper = boolean(periods_table.hypergravity);
bOther = ~bitor(bitor(bTrans,bPara),bHyper);
bNotTrans = ~bTrans;

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

subplot(3,1,[1 2]);
scatter(periods_table.g_bar_norm(bTrans),periods_table.duration_s(bTrans),'.k'); hold on;
scatter(periods_table.g_bar_norm(bPara),periods_table.duration_s(bPara),'ok'); hold on;
scatter(periods_table.g_bar_norm(bHyper),periods_table.duration_s(bHyper),'sk'); hold on;
scatter(periods_table.g_bar_norm(bOther),periods_table.duration_s(bOther),'^k'); hold on;
set(gca, 'YScale', 'log')
xlabel('Mean G level');
ylabel('Duration (s)');
legend('Transition','Parabola','Hypergravity','Other','location','NorthWest');

% Add classifier lines
% Default classifier duration threshold is 100 s
h = plot(get(gca,'xlim'),[100 100],'-k'); h.Color(4) = 0.5;
% Default classifier g-level thresholds are [-0.1 0.9 1.1]
h = plot([0.9 0.9],[1 100],':k'); h.Color(4) = 1;
h = plot([1.1 1.1],[1 100],':k'); h.Color(4) = 1;

subplot(3,1,3);
histogram(periods_table.g_bar_norm(bNotTrans),100)
xlabel('Mean G level');
ylabel('Number of Periods');

% Print
fig.PaperUnits = 'inches'; w = 8; h = 8;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});