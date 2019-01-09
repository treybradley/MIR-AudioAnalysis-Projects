% Trey Bradley
% October 2, 2018


% MIR - Assignment 1_Implementation 1


% This function will generate and plot a sine sweep.
function x_t = sine_sweep(f_min, f_max, fs, duration, a)

% The following does various error checks
if nargin < 5
    error('Please define Min and Max Frequencies, Sample Rate, Duration, and amplitude')
end

if a <= 0 || a > 1
    error('Amplitude Should be Positive and no greater than 1')
end

if f_min < 20 || f_max > 20000
    error('Frequencies Should be within the Audible Fq. Range')
end

if fs < (2 * f_max)
    error('Beware of Aliasing')
end

% Convert sec duration into samples
d = fs*duration;

% Create logarithmically spaced vector. Convert frequencies into log scale
f = logspace(log10(f_min),log10(f_max),d);

% Return sine sweep vector
x_t = a * sin(cumsum((2*pi*f)/fs));

% Play back result
soundsc(x_t,fs);

end