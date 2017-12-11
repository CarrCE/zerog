% analysis_test.m
%
% Analysis of test 14.2 s data recording under lab bench conditions.
%

%% Start fresh
clear all; close all; clc;

%% Load data
load('./Test/SSX51381_Ch32_02.mat');

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

%% Compute Mean, Std, RMS g-level
g_bar = mean(g)
g_sd = std(g)
g_rms = rms(g)



