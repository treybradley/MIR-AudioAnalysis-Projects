% Trey Bradley
% October 18, 2018
% MIR - Assignment 2_Implementation 2


function [onset_a, onset_t, n_t_smoothed, thresh] = onsets_from_novelty(n_t, t, fs, w_c, medfilt_len, offset)

% 1.0 Smoothing: define cutoff fq. and normalize it for butterworth filter (0-1)
nq = fs/2;
cutoff_fq = w_c/nq;
[b, a] = butter(1,cutoff_fq,'low');
nf_smooth = filtfilt(b,a,n_t);

% 2.0 Normalize our smoothed novelty function
n_t_smoothed = nf_smooth/max(nf_smooth);

% 3.0 Peak Picking
% 3.1 Thresholding: Apply median filtering to the nth order, and add the offset
medfilter = medfilt1(n_t_smoothed,medfilt_len);
thresh = medfilter + offset;

% 3.2 Find all local maxima of novelty function (that is smoothed and normal)
[peak, ost] = findpeaks(n_t_smoothed);

% 3.3 Find locations in threshold, where novelty function's peaks occur
peaks_at_thresh = thresh(ost);

% 3.4 Calculate difference between threshold and novelty's peaks and the
% location where novelty's peaks also exceeds the threshold
dif = peak - peaks_at_thresh;
[dd, ee] = find(dif > 0);

% 3.5 Select the novelty's peaks that also exceed the threshold find their location
onset_a = peak(ee);
onset_loca = ost(ee);

% 3.6 take above output of times of onset events and convert to seconds
u = length(t)/fs;
onset_t = (u * onset_loca)/size(thresh, 2);

end