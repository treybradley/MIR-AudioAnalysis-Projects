
% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 7 and Analysis

% import audio from file path
piano_train = 'audio3/piano_train.wav';
piano_test = 'audio3/piano_test.wav';
trombone_train = 'audio3/trombone_train.wav';
trombone_test = 'audio3/trombone_test.wav';
trumpet_train = 'audio3/trumpet_train.wav';
trumpet_test = 'audio3/trumpet_test.wav';

% set mfcc feature extraction parameters
params.win_size = 1024;
params.hop_size = 512;
params.min_freq = 86;
params.max_freq = 8000;
params.num_mel_filts = 40;
params.n_dct = 15;


%% Piano versus Trumpet

% Analysis 1 - MFCC feature training set for piano and trumpet
[train_features1, train_labels1] = create_set(piano_train, trumpet_train, params);

% Analysis 2 - MFCC feature testing set for piano and trumpet
[test_features1, test_labels1] = create_set(piano_test, trumpet_test, params);

% Analysis 3 - overall accuracy and accuracy per class ... use predict_labels and score_prediction functions
[predicted_labels1] = predict_labels(train_features1, train_labels1, test_features1);

% outputs overall and class-specific accuracy
[overall_accuracy1, per_class_accuracy1] = score_prediction(test_labels1, predicted_labels1);

% Analysis 4 - Display results
disp('Overall % Accuracy for classifying Piano versus Trumpet is ')
disp(overall_accuracy1)
disp('Per Class % Accuracies for classifying Piano versus Trumpet are ')
disp(per_class_accuracy1)

%% Trombnone versus Trumpet

% Analysis 5 - repeat for trombone and trumpet classification
% Analysis 1 - MFCC feature training set for piano and trumpet
[train_features2, train_labels2] = create_set(trombone_train, trumpet_train, params);

% Analysis 2 - MFCC feature testing set for piano and trumpet
[test_features2, test_labels2] = create_set(trombone_test, trumpet_test, params);

% Analysis 3 - overall accuracy and accuracy per class ... use predict_labels and score_prediction functions
[predicted_labels2] = predict_labels(train_features2, train_labels2, test_features2);

% outputs overall and class-specific accuracy
[overall_accuracy2, per_class_accuracy2] = score_prediction(test_labels2, predicted_labels2);

% Analysis 4 - Display results
disp('Overall % Accuracy for classifying Trombone versus Trumpet is ')
disp(overall_accuracy2)
disp('Per Class % Accuracies for classifying Trombone versus Trumpet are ')
disp(per_class_accuracy2)