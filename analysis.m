% analysis.m
%
% Analysis of Zero G Flight Acceleration Profile
%
% Christopher E. Carr
% chrisc at mit dot edu
% 2017/11/29
%
% Tested with MATLAB 2017a on OS X 10.12
% Expected to work with MATLAB 2016a+
%
% Dependencies
% ----------------------------------
% Signal Processing Toolbox (2016a+)
%   pwelch (R2006a+)
%   designfilt (R2014a+)
%   findchangepts (R2016a+)
%
% MATLAB
%   struct2table (2013b)
%   writetable (2013b)
%

%% Start fresh
clear all; close all; clc;

%% Set Analysis Options

% Parabola Detection (see SegmentFlight function)
N_Parabolas = 20;
N_Sets = 4;
N_ChangePoints = N_Parabolas*2 + N_Sets*2;
% Number of seconds near change points to look for transition points
T_tp = 10;

% Zero-Delay Filter Options for G-level filtering
HPF = 0.01;     % Half Power Frequency (HPF) [Hz]
% Other Filter options
FilterOptions = {'lowpassiir','FilterOrder',12,'DesignMethod','butter'};

% Graphics format for saving figures {file_extension, MATLAB print option}
% Type 'help print' for examples
figformat = {'pdf' '-dpdf'};

% LineWidth for figure plotting
lw = 0.75;      

% Folder for outputs (e.g., figures)
outfolder = 'analysis';

% derive start time (from README.txt file)
start_time_utc_string = '2017-11-17 18:28:51';
start_time = datetime(start_time_utc_string,'InputFormat','yyyy-MM-dd HH:mm:ss','TimeZone','UTC');
start_time.TimeZone = '-05:00'; % Florida on 11/17/17 is UTC - 5

%% Create output folder
if ~exist(outfolder,'dir'), mkdir(outfolder); end

%% Get calibrated data
%load('./Flight/Ch08.mat');        % Piezoelectric Accelerometer
load('./Flight/Ch32.mat');         % DC Accelerometer
load('./Flight/Ch36.mat');         % Pressure, Temperature
load('./Flight/Ch59.mat');         % Touchpad P, T

%% Give short meaningful names to data
t = Low_g_Acceleration(1,:);
g_x = Low_g_Acceleration(2,:);
g_y = Low_g_Acceleration(3,:);
g_z = Low_g_Acceleration(4,:);

%% Get sampling frequency and period
Ts = mean(diff(t));
Fs = 1/Ts;

%% Calculate g-level (norm)
g = sqrt(g_x.^2 + g_y.^2 + g_z.^2);

%% Power Spectral Density (PSD) of G-level

% Compute PSD using Welch's method (pwelch.m) with default parameters.
% Units: g^2 / Hz. "By default, X is divided into the longest possible 
% sections, to get as close to but not exceeding 8 segments with 50% 
% overlap."
[psd,f]=pwelch(g,[],[],[],Fs);

%% Make PSD figure
analysis_fig_g_level_psd;

%% Accelerometer Data Filtering

% Use zero-phase filter to avoid introducing delays following:
% https://www.mathworks.com/help/signal/ref/filtfilt.html

% Design the filter
d1 = designfilt(FilterOptions{:},'HalfPowerFrequency',HPF);

% Do the filtering
g_x_filt = filtfilt(d1,g_x);
g_y_filt = filtfilt(d1,g_y);
g_z_filt = filtfilt(d1,g_z);

%% Calculate the filtered G-level (norm of the filtered g vector)
g_filt = sqrt(g_x_filt.^2 + g_y_filt.^2 + g_z_filt.^2);

%% Plot the g-level (unfiltered and filtered)
analysis_fig_g_level;

%% Plot Unfiltered and Filtered G_x, G_y, G_z
analysis_fig_unfilt_vs_filt;

%% Plot comparison of "good" and "bad" filters (HPF)
analysis_fig_filt_good_vs_bad;

%% Segment the flight by change point detection
[cp,tp]=SegmentFlight(g_filt,N_ChangePoints,Fs,T_tp);

%% Show the segmented flight
analysis_fig_segmented;

%% Classify the segments
periods = ClassifySegments(cp,tp,t,[g_x;g_y;g_z]);

%% Save the periods data to a file
periods_table = struct2table(periods);
writetable(periods_table,fullfile(outfolder,'periods.txt'),'Delimiter','\t');

%% Plot showing G-level and duration
analysis_fig_g_level_duration;

%% Plot showing regression of G-level and duration
analysis_fig_parabola_duration;

%% Plot showing Pressure and Temperature
analysis_fig_PressTemp;

%% Save the filtered g-level data

% MAT file
save(fullfile(outfolder,'G_filt.mat'),'t','g_x_filt','g_y_filt','g_z_filt','g_filt','start_time');

% Tab delimited file: time is elapsed time, so add local time to filename
fn_base = fullfile(outfolder,sprintf('G_filt.%s',datestr(start_time,'yyyy-mm-dd_HH_MM_SS')));
% Make a table with columns
g_filt_table = table(t',g_x_filt',g_y_filt',g_z_filt',g_filt');
% Correct the table column names
g_filt_table.Properties.VariableNames = {'t','g_x_filt','g_y_filt','g_z_filt','g_filt'};
% Write the table; zip for storage
writetable(g_filt_table,[fn_base '.txt'],'Delimiter','\t');
zip([fn_base '.txt.zip'],[fn_base '.txt']); delete([fn_base '.txt']);
