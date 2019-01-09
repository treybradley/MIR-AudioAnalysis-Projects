% Trey Bradley
% October 18, 2018
% MIR - Assignment 2_Implementation 3


function [] = create_novelty_plots(filepath, win_size, hop_size, w_c, medfilt_len, offset)

% Waveform
[x_t, fs, t] = import_audio(filepath);

% Plots
subplot(3,1,1)
plot(t,x_t)
title('Signal')
lim = length(t)/fs;
xlim([0 lim]);
legend({'Signal'},'Location','northeast')


% Log Energy (LE) derivative novelty function
[n_t_le, t_le, fs_le] = compute_novelty_le(x_t, t, fs,win_size, hop_size);
[onset_a, onset_t, n_t_smoothed, thresh] = onsets_from_novelty(n_t_le, t_le, fs_le, w_c, medfilt_len, offset);

subplot(3,1,2)
plot(t_le,n_t_le,'r',t_le,n_t_smoothed,'k',t_le,thresh,'b:',onset_t,onset_a,'ko')
lim = length(t)/fs;
xlim([0 lim]);
legend({'NF LE','Smoothed NF','Threshold','Picked Peaks'},'Location','northeast')
title('Novelty Function (NF) Local Energy (LE) Peak Picking')


% Spectral Flux (SF) novelty function
[n_t_sf, t_sf, fs_sf] = compute_novelty_sf(x_t, t, fs,win_size, hop_size);
[onset_a, onset_t, n_t_smoothed, thresh] = onsets_from_novelty(n_t_sf, t_sf, fs_sf, w_c, medfilt_len, offset);

subplot(3,1,3)
plot(t_sf,n_t_sf,'r',t_sf,n_t_smoothed,'k',t_sf,thresh,'b:',onset_t,onset_a,'ko')
lim = length(t)/fs;
xlim([0 lim]);
legend({'NF SF','Smoothed NF','Threshold','Picked Peaks'},'Location','northeast')
title('Novelty Function (NF) Spectral Flux (SF) Peak Picking')

end