% analysis_fig_segmented.m
%
% Show results of SegmentFlight.
%

% Filename for this figure
fn = 'analysis_fig_segmented';

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

%% First subplot
subplot(5,1,1);

% First plot filtered g-level (blue)
plot(t,g_filt,'linewidth',lw); hold on;

% Plot change points as vertical lines
for k=1:N_ChangePoints,
    % Plot current change point
    plot(t(cp(k))*[1 1],[-0.2 1.8],'-','Color',[0.5 0.5 0.5],'Linewidth',lw); hold on;
end

set(gca,'xlim',[0 max(t)]);
set(gca,'ylim',[-0.2 1.8]);
% Add axis labels
xlabel('Time (s)'); ylabel('G_{filt}');

% Set limits to focus on parabolas
set(gca,'xlim',[1000 3800]);

%% Second subplot
subplot(5,1,2);

% First plot filtered g-level (blue)
plot(t,g_filt,'linewidth',lw); hold on;

% Plot change points as vertical lines
for k=1:N_ChangePoints,
    % Plot current change point
    plot(t(cp(k))*[1 1],[-0.2 1.8],'-','Color',[0.5 0.5 0.5],'Linewidth',lw); hold on;
end

set(gca,'xlim',[0 max(t)]);
set(gca,'ylim',[-0.2 1.8]);
% Add axis labels
xlabel('Time (s)'); ylabel('G_{filt}');

% Zoom to focus on one parabola set
set(gca,'xlim',[1100 1600]);
set(gca,'ylim',[-0.2 1.8]);

%% Third subplot: Mars Parabola
subplot(5,1,3);

% Plot g components
plot(t,g_x_filt,'linewidth',lw); hold on;
plot(t,g_y_filt,'linewidth',lw); hold on;
plot(t,g_z_filt,'linewidth',lw); hold on;
xlabel('Time (s)');
ylabel('G_{filt}');

% Add change points and transition points
for k=1:N_ChangePoints,
    % Add change point
    plot(t(cp(k))*[1 1],[-0.2 1.8],'-','Color',[0.5 0.5 0.5],'Linewidth',lw); hold on;
    % Add transition boundaries
    plot(t(tp(1,k))*[1 1],[-0.2 1.8],':b','Linewidth',lw);
    plot(t(tp(2,k))*[1 1],[-0.2 1.8],':b','Linewidth',lw);
end

legend('X','Y','Z','Location','eastoutside')
set(gca,'ylim',[-0.2 1.8]);
set(gca,'xlim',[1230 1310]); % Mars g

%% Third subplot: Lunar Parabola
subplot(5,1,4);

% Plot g components
plot(t,g_x_filt,'linewidth',lw); hold on;
plot(t,g_y_filt,'linewidth',lw); hold on;
plot(t,g_z_filt,'linewidth',lw); hold on;
xlabel('Time (s)');
ylabel('G_{filt}');

% Add change points and transition points
for k=1:N_ChangePoints,
    % Add change point
    plot(t(cp(k))*[1 1],[-0.2 1.8],'-','Color',[0.5 0.5 0.5],'Linewidth',lw); hold on;
    % Add transition boundaries
    plot(t(tp(1,k))*[1 1],[-0.2 1.8],':b','Linewidth',lw);
    plot(t(tp(2,k))*[1 1],[-0.2 1.8],':b','Linewidth',lw);
end

legend('X','Y','Z','Location','eastoutside')
set(gca,'ylim',[-0.2 1.8]);
set(gca,'xlim',[1310 1390]); % Lunar g

%% Third subplot: Zero g parabola
subplot(5,1,5);

% Plot g components
plot(t,g_x_filt,'linewidth',lw); hold on;
plot(t,g_y_filt,'linewidth',lw); hold on;
plot(t,g_z_filt,'linewidth',lw); hold on;
xlabel('Time (s)');
ylabel('G_{filt}');

% Add change points and transition points
for k=1:N_ChangePoints,
    % Add change point
    plot(t(cp(k))*[1 1],[-0.2 1.8],'-','Color',[0.5 0.5 0.5],'Linewidth',lw); hold on;
    % Add transition boundaries
    plot(t(tp(1,k))*[1 1],[-0.2 1.8],':b','Linewidth',lw);
    plot(t(tp(2,k))*[1 1],[-0.2 1.8],':b','Linewidth',lw);
end

legend('X','Y','Z','Location','eastoutside')
set(gca,'ylim',[-0.2 1.8]);
set(gca,'xlim',[1390 1470]); % Zero g

%% Generate PDF figure
% Print
fig.PaperUnits = 'inches'; w = 8; h = 10;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});

