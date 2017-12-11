% analysis_fig_PressTemp.m
%
% Plot of Pressure and Temperature during flight.
%

%% Pressure & Temperature Data

% Filename for this figure
fn = 'analysis_fig_PressTemp';

% Make the figure
fig = figure; set(gcf,'color',[1 1 1]);

PT = Pressure_Temperature;
N_PT = size(PT,2);
t_PT = PT(1,:);

yyaxis left;
plot(PT(1,:),PT(2,:)/1E3,'-'); hold on;
ylabel('Pressure (kPa)');

yyaxis right;
plot(PT(1,:),PT(3,:),'-');
ylabel('Temperature (^{\circ}C)');
xlabel('Time (s)');

% Can use matlab function to estimate pressure altitude from pressure. 
% Note: This is uncorrected for temperature.
% press_alt = atmospalt(PT(2,:));
% figure; plot(PT(1,:),press_alt);

% Print
fig.PaperUnits = 'inches'; w = 8; h = 5;
fig.PaperPosition = [0 0 w h];
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});