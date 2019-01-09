% Trey Bradley
% October 18, 2018
% MIR - Assignment 2_Implementation 4

% Implementation
filepath = 'T08-violin.wav';
win_size = 1024;
hop_size = 512;
w_c = 4;
medfilt_len = 7;
offset = .02;

create_novelty_plots(filepath, win_size, hop_size, w_c, medfilt_len, offset)