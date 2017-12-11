%% analysis_fig_g_level_psd.m

% Filename for this figure
fn = 'analysis_fig_g_level_psd';
% Typical plot limits for PSD for aircraft vibrations
ylim = [0 1E-3];
xlim = [0 Fs/2];

% Make the figure
figure; set(gcf,'color',[1 1 1]);

% compute cumulative sum of power spectrum with frequency
cpsd = cumsum(psd)/sum(psd);

% First plot
subplot(2,1,1);
plot(f,psd,'linewidth',lw);
set(gca,'ylim',ylim,'xlim',xlim);
xlabel('Frequency (Hz)');
ylabel('PSD of G (g^2 / Hz)');

% Plot cumulative sum of power spectrum with frequency
subplot(2,1,2); 
plot(f,cpsd,'linewidth',lw); hold on;
set(gca,'xscale','log');
xlabel('Frequency (Hz)'); ylabel('PSD Normalized Cum. Sum');
set(gca,'xlim',xlim);
% Add selected HPF point
plot(HPF,interp1(f,cpsd,HPF),'ok');

% Print
print(fullfile(outfolder,[fn '.' figformat{1}]),figformat{2});

% Show inset plot of spectrum power near DC

fig=figure; set(gcf,'color',[1 1 1]); 
plot(f,20*log10(psd),'linewidth',lw); 
set(gca,'xlim',[0 5],'ylim',[-200 100]); 
xlabel('Frequency (Hz)'); ylabel('PSD (dB)');
fig.PaperUnits = 'inches'; w = 3; h = 2;
fig.PaperPosition = [(8.5-w)/2 (11-h)/2 w h];

% Print
print(fullfile(outfolder,[fn '.inset.' figformat{1}]),figformat{2});