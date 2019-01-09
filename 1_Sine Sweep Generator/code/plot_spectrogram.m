% Trey Bradley
% October 2, 2018


% MIR - Assignment 1_Implementation 2


% This function computes and plots the spectrogram of a sine sweep, using the
% matlab spectrogram function
function [] = plot_spectrogram(x_t,win_size, hop_size, win_type, fs, nfft)

%% The following does various error checks
if nargin < 6
    error('Please define all variables')
end

if win_size == hop_size || win_size < hop_size
    error('Error! Window length cannot be equal to or smaller than overlap length')
end

if ~(strcmp(win_type, 'rect') || strcmp(win_type, 'hamming') || strcmp(win_type, 'hann') || strcmp(win_type, 'blackman'))
    error('Stipulate window type or spell it right')
end

%% Compute spectrogram according to input variables
if (strcmp(win_type, 'hann'))
    spect_xt = spectrogram(x_t,hann(win_size),hop_size,nfft);
      
elseif (strcmp(win_type, 'hamming'))
    spect_xt = spectrogram(x_t,hamming(win_size),hop_size,nfft);
    
elseif (strcmp(win_type, 'rect'))
    spect_xt = spectrogram(x_t,rectwin(win_size),hop_size,nfft);
    
    elseif (strcmp(win_type, 'blackman'))
    spect_xt = spectrogram(x_t,blackman(win_size),hop_size,nfft);
end

spect_xt = (spect_xt)./(max(abs(spect_xt)));% normalize freq
%% create a vector to represent fq axis
fqRes = fs / nfft; %frequency resolution in Hz
xAx = (0:fqRes:(fs/2))'; %frequency values to display on y-axis 

% create a vector to represent time axis
duration = 1;
tRes = duration / size(spect_xt, 2);
tVect = 0:tRes:duration-tRes;

% Plot the above axes and array
figure();
imagesc(tVect,xAx,20*log10(abs(spect_xt))); % convert energies to DB
set(gca, 'YDir', 'normal'); %flips the y-axis so zero zero is origin

C = colorbar('location','eastoutside');
set(get(C,'YLabel'),'String','Power');

ylim( [0 fs/2] );
xlabel('Time');
ylabel('Frequency');
title('Plot Spectrogram Implementation 2');

end