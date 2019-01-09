% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 3


function [mfccs, fs_mfcc] = compute_mfccs(filepath, win_size, hop_size, min_freq, max_freq, num_mel_filts, n_dct)


% import audio signal, make it mono if it isn't already
[x, fs] = audioread(filepath);
if size(x,2) > 1
     x_t = x(:,1)';
else
     x_t = x';
end


% Compute spectrogram with hamming window - spectrogram and output frequency vector
x_t_spectrogram = spectrogram(x_t,hamming(win_size),hop_size);
x_t_magSpectrogram = abs(x_t_spectrogram); % take magnitude spectrum
X_k = x_t_magSpectrogram .^ 2; % square the magnitude spectrum for energy


% Compute filterbank according to filter function re: triangle shape, etc.
% 1 - warp min and max freq. to mel scale
melScale_min = hz2mel(min_freq);
melScale_max = hz2mel(max_freq);

% 2 - get # of midpoints, based on # mel filters in the bank
melSteps = (melScale_max - melScale_min) / (num_mel_filts + 2);

% 3 - create vector of mel scale midpoints (uniformly distributed)
melPts = (melScale_min : melSteps : melScale_max);

% 4 - convert mel center points into frequency center points
fqPts = mel2hz(melPts);

% 5 - build zero matrix for filter bank and for loop
H_k = zeros(num_mel_filts, size(X_k,1));

% 6 - construct freq. vector of bank range for loop and plotting (to check bank construction)
f = linspace(min_freq, max_freq, size(X_k,1)); % frequency range (Hz), size 1xK

% 7 - Index for every filter in bank. Create upslopes and downslopes for triangle shape
for m = 1 : num_mel_filts
    k = f >= fqPts(m) & f <= fqPts(m + 1);
    H_k(m,k) = 2 * (f(k) - fqPts(m)) / ((fqPts(m + 2) - fqPts(m)) * (fqPts(m + 1) - fqPts(m)));
    k = f >= fqPts(m + 1) & f <= fqPts(m + 2);
    H_k(m,k) = 2 * (fqPts(m + 2) - f(k)) / ((fqPts(m + 2) - fqPts(m)) * (fqPts(m + 2) - fqPts(m + 1)));
end
% plot(f, H_k)


% Matrix multiply mel filter bank with energy to output energies for each filter
s_m = H_k * X_k;

% Compute log mel energy for each filter in bank
S_m = 20 * log10(s_m);

% compute DCT of log of the mel spectrum
DCT = dct(S_m);

% truncate the DCT results by M = n_dct to keep the relevant coefficients
mfccs = DCT(2 : n_dct , 1:end); % start at 2nd row to remove 1st row
mfccs = mfccs / max(mfccs(:)); % normalize mfccs

% output sample rate of system
time = linspace(0 , length(x_t) / fs , length(x_t));
drtn = length(time) / fs;
fs_mfcc = length(mfccs) / drtn;

end