% analysis_fig_parabola_duration.m
%
% Plot of regression of parabola duration vs. g level
%
 
%% Regression of parabola duration and g-level
bPara = (periods_table.parabola==1);
Y = periods_table.duration_s(bPara)';
X = periods_table.g_bar_norm(bPara)';
lm = fitlm(X,Y,'linear')
% 95 confidence intervals
coefCI(lm)

% Be careful not to over-interpret, since without
% limited lunar, mars data there might not be much here.

b0 = bitand(periods_table.parabola==1,periods_table.g_bar_norm<0.15);
Y0 = periods_table.duration_s(b0)';
X0 = periods_table.g_bar_norm(b0)';
lm0 = fitlm(X0,Y0,'linear')

% Filename for this figure
fn = 'analysis_fig_parabola_duration';

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

% plot
subplot(2,1,1);
plot(lm); title('');
xlabel('Mean G level');
ylabel('Parabola Duration (s)');

% You can also look at the residuals in a variety of ways...
% look pretty good except one zero g parabola
% figure; plotResiduals(lm,'probability')
% figure; plotResiduals(lm,'lagged')

subplot(2,1,2);
plot(lm0); title('');
xlabel('Mean G level');
ylabel('Parabola Duration (s)');

% Print
fig.PaperUnits = 'inches'; w = 8; h = 8;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});

%% Some parabola statistics

% Find lunar parabola
bL = bitand(bPara,bitand(periods_table.g_bar_norm>0.15,...
                         periods_table.g_bar_norm<0.2));
                     
% Find Mars parabolas
bM = bitand(bPara,bitand(periods_table.g_bar_norm>0.2,...
                         periods_table.g_bar_norm<0.5));

% Duration of zero g parabolas
d0_mean = mean(periods_table.duration_s(b0))
d0_std = std(periods_table.duration_s(b0))
% Mean g level achieved during zero g parabolas
g0_mean = mean(periods_table.g_bar_norm(b0))
g0_std = std(periods_table.g_bar_norm(b0))

% Duration of Lunar parabola
dL = periods_table.duration_s(bL)
% Mean g level during lunar parabola
gL = periods_table.g_bar_norm(bL)

% Duration of Mars g parabolas
dM_mean = mean(periods_table.duration_s(bM))
dM_std = std(periods_table.duration_s(bM))
% Mean g level achieved during zero g parabolas
gM_mean = mean(periods_table.g_bar_norm(bM))
gM_std = std(periods_table.g_bar_norm(bM))

