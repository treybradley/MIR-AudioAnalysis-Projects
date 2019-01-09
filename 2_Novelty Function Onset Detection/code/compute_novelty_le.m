% Trey Bradley
% October 18, 2018
% MIR - Assignment 2_Implementation 1a


function [n_t_le, t_le, fs_le] = compute_novelty_le(x_t, t, fs,win_size, hop_size)

% 1.0 Create window vector
wV = hamming(win_size+1);

% 1.1 - buffer signal
y = buffer(x_t,win_size,hop_size);

% 1.2 - create vector that contains elements of the signal, which starts
% from hop_size units into the signal (to achieve N/2 and -N/2 frames)
z = x_t((hop_size+1):hop_size:end);
o = zeros(size(y,2)-size(z,2));
xx = horzcat(z,o);
yy = vertcat(y,xx);

% 2.0 - Squaring and Windowing each frame to find local energy, using for loop
for n = 1:size(yy, 2)
    Col = yy( :, n);
    Col = (Col.^2) .* wV;
    yy( :, n) = Col;
end

% 2.1 - Sum each frame and normalize by N to complete log energy
locE = sum(yy)/win_size;

% 2.2 - Find log energy derivative of the local energy function. Log calculates percieved changes in loudness
n_t_le = diff(log(locE));
n_t_le = n_t_le/max(n_t_le); % normalize

% 3.1 - Output a new time vector
duration = length(t)/fs;
tr = duration / size(n_t_le,2);
t_le = (0:tr:duration-tr);

% 3.2 - Output Novelty Function Sample rate
fs_le = length(n_t_le)/duration;

end