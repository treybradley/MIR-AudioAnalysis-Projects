% Trey Bradley
% October 2, 2018


% MIR - Assignment 1_Implementation 3


% This function computes the spectrogram of the sine sweep signal, using
% matrix multiplication
function [S, F, T] = my_spectrogram(x_t,window, noverlap, nfft,fs)

%% The following does various error checks
if nargin < 5
    error('Please define all variables')
end

if size(window,1) == noverlap || size(window,1) < noverlap
    error('Error! Window length cannot be equal to or smaller than overlap length')
end

%% Use buffer function to reformat signal array, according to user input window size and hop size
wsize = size(window,1);
buffxt = buffer(x_t, wsize, noverlap);

% Assess if zero padding needed ... zero pad if necessary
if nfft > wsize
    X = padarray(buffxt,(nfft - wsize),0,'pre');
elseif nfft == wsize
    X = buffxt;
end

% Apply windowing to signal
for e = 1:size(X, 2)
    Xcol = X( :, e);
    Xcol = Xcol .* window;
    X( :, e) = Xcol;
end

% Compute the S matrix of complex sinusoids
N = size(X,1);
j = sqrt(-1);
Sinu = zeros(N,N);

for n = 0:(N-1)
    for k = 0:(N-1)
        Sinu(n+1,k+1) = Sinu(n+1,k+1) + conj(cos(2*pi*n*k/N) + j*sin(2*pi*n*k/N));
    end
end

%% Perform Matrix multiplication of the buffered signal times matrix of sinusoids
x = Sinu * X;

S = x(1:end-(nfft/(2)),:); % truncate results of matrix
S = (S)./(max(abs(S))); % normalize freq

%% Create a vector to represent fq axis
%fqRes = fs / size(S, 1); %frequency resolution in Hz
fqRes = fs / N; %frequency resolution in Hz
F = (0:fqRes:(fs/2))'; %frequency values to display on y-axis 

% create a vector to represent time axis
D = 1;
tRes = D / size(S, 2);
T = 0:tRes:D-tRes;

% Plot the above axes and array
figure();
imagesc(T,F,20*log10(abs(S))); % convert power to dB
set(gca, 'YDir', 'normal'); % flips the y-axis so zero zero is origin

C = colorbar('location','eastoutside');
set(get(C,'YLabel'),'String','Power');

ylim( [0 fs/2] );
xlabel('Time');
ylabel('Frequency');
title('My Spectrogram Implementation 3');

end