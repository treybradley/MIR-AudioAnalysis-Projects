% Trey Bradley
% November 27, 2018
% MIR - Assignment 4_Implementation 2


function [] = plot_pitch(filepath, win_size, hop_size, min_lag, max_lag)

[x_t, fs] = audioread(filepath);
t = linspace(0, length(x_t) / fs, length(x_t));


[pitch_acf, t_pitch_acf] = detect_pitch_acf(x_t', t, fs, win_size, hop_size, min_lag, max_lag);
figure();
subplot(2, 1, 1);
plot(t_pitch_acf, pitch_acf, '.k');
title('ACF Plot');
xlabel('Time');
ylabel('Frequency');

[pitch_yin, t_pitch_yin] = detect_pitch_yin(x_t', t, fs, win_size, hop_size, min_lag, max_lag);
subplot(2, 1, 2);
plot(t_pitch_yin, pitch_yin, '.k');
title('YIN Plot');
xlabel('Time');
ylabel('Frequency');

end