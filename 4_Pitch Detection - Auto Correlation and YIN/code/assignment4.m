% Trey Bradley
% November 27, 2018
% MIR - Assignment 4_Implementation 3


% % Default Parameters
% filepath = 'jazz2REF.wav';
% win_size = 2048;
% hop_size = 256;
% min_lag = 15;
% max_lag = 800;
% plot_pitch(filepath, win_size, hop_size, min_lag, max_lag);
% 
% filepath = 'T08-violin.wav';
% win_size = 2048;
% hop_size = 256;
% min_lag = 15;
% max_lag = 800;
% plot_pitch(filepath, win_size, hop_size, min_lag, max_lag);


% Optimized Parameters 1
filepath = 'jazz2REF.wav';
win_size = 2048;
hop_size = 1024;
min_lag = 15;
max_lag = 400;
plot_pitch(filepath, win_size, hop_size, min_lag, max_lag);

filepath = 'T08-violin.wav';
win_size = 2048;
hop_size = 512;
min_lag = 15;
max_lag = 400;
plot_pitch(filepath, win_size, hop_size, min_lag, max_lag);