% Trey Bradley
% October 18, 2018
% MIR - Assignment 2_Implementation 0


function [x_t, fs, t] = import_audio(filepath)

% import signal
[x, fs] = audioread(filepath);

% set mono if signal is stereo
if size(x,2) > 1
    x_t = x(:,1)';
else
    x_t = x';
end

% create time vector
t = linspace(0,length(x_t)/fs , length(x_t));

% Play Audio
soundsc(x_t,fs);

end