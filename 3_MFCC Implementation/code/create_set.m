% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 4


function [features, labels] = create_set(fpath1, fpath2, params)

% compute mfccs for each file within filepath1 and filepath2...instrument classes
[mfccs1] = compute_mfccs(fpath1, params.win_size, params.hop_size, params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);

[mfccs2] = compute_mfccs(fpath2, params.win_size, params.hop_size, params.min_freq, params.max_freq, params.num_mel_filts, params.n_dct);


% vector of 1s and 2s to label mfccs for each class...vectors for each class will have length of # of columns in mfcc feature matrices
% use this to index in prediction module
labels1 = ones(1, length(mfccs1));
labels2 = ones(1, length(mfccs2)) .* 2;

features = horzcat(mfccs1,mfccs2);

labels = horzcat(labels1,labels2);

end