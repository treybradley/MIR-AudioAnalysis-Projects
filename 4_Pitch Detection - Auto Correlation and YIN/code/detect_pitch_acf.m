% Trey Bradley
% November 27, 2018
% MIR - Assignment 4_Implementation 1a


function [pitch, t_pitch] = detect_pitch_acf(x_t, t, fs, win_size, hop_size, min_lag, max_lag)

% segment signal by window length and hop amount
x_n = buffer(x_t , win_size , (win_size - hop_size));

% build matrix of lag values
lag = (min_lag : max_lag);

% autocorrelation function for loop
for j = 1 : size(x_n,2) % grab first frame of time-domain signal
    
for i = 1 : size(lag , 2) % index for all lagged values between min and max
    x_n_l_Col = x_n(:, j); % grab column (window) from time-domain signal
    x_n_l_Col = x_n_l_Col(lag(i) : end); % get lagged segment of window
    x_n_l_Col = padarray(x_n_l_Col , lag(i) - 1 , 0 , 'post'); % add zeros for vector multiplication
    x_n_l_Col =  ((x_n(:, j))' * x_n_l_Col) / (win_size - lag(i) - 1); % auto-correlation function
    x_n_l(:,i) = x_n_l_Col; % create vector of pitch estimates at each frame by max function
end

[~ , loc] = max(x_n_l); % find max of autocorrelation in each frame
lagamt = lag(loc);
pitch(:, j) = (1 / lagamt) * fs;
end

% output time in lags
t_pitch = t(end) / size(x_n , 2) : t(end) / size(x_n , 2) : t(end);

end