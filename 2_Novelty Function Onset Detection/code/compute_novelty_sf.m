% Trey Bradley
% October 18, 2018
% MIR - Assignment 2_Implementation 1b


function [n_t_sf, t_sf, fs_sf] = compute_novelty_sf(x_t, t, fs,win_size, hop_size)

% 1.0 - Compute Spectrogram...
% 1.1 - Window Vector
wv = hamming(win_size);

% 1.2 - Buffer Signal
bufsig = buffer(x_t,win_size,hop_size);

% 1.3 - Window Signal
for n = 1:size(bufsig, 2)
    column = bufsig( :, n);
    column = column .* wv;
    bufsig( :, n) = column;
end

% 1.4 - Compute fft of each frame
stft = fft(bufsig);

% 1.5 - Take freq. magnitude, normalize, put on log scale
mag = abs(stft);
mag = (mag)./(max(abs(mag)));
dB = abs(mag); % matrix that we will perform the SFr on...

% 2.0 - Start SF
% Take current frame and subtract previous frame (abs value already
% computed above)
sf = diff(dB,[],2);

% 2.1 - Half-wave rectify by taking frame, adding to itself its absolute value
% and dividing by 2.
for nn = 1:size(sf,2)
col = sf(:, nn);
col = (col + abs(col))/2;
sf( :,nn) = col;
end

% 2.2 - Take the sum of each sample in the frame to yield a single hor. vector
sumH_x = sum(sf);

% 2.3 - Multiply each column in our hor vector by 2/N to yeild the SFr
ntsf = sumH_x * (2/win_size);

% 2.4 - Normalize spectrul flux
n_t_sf = ntsf/max(ntsf);

% 3.0 - Output a new time vector
% d = length(x_t)/fs;
d = length(t)/fs;
tr = d / size(n_t_sf, 2); % total number of samples now
t_sf = 0:tr:d-tr;

% 3.1 - Output Novelty Function Sample rate
fs_sf = length(n_t_sf)/d;

end