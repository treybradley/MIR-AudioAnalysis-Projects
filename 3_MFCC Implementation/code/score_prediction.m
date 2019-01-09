% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 6


function [overall_accuracy, per_class_accuracy] = score_prediction(test_labels, predicted_labels)

% compare predicted labels and test labels by taking the difference (zero if prediction is correct)
compare = test_labels - predicted_labels;

% find the number of wrong predictions (non-zero elemnts in difference between test labels and predicitions
wrongPredictions = nnz(compare);

% overall accuracy of predicitons will be # wrong predictions / total predicitons ... adjust to find percentage of correct
overall_accuracy = (1 - (wrongPredictions / length(test_labels))) * 100;


% calculate per class accuracy for each instrument
classIndex = find((test_labels) - 1 , 1 , 'first'); % separate test labels by class
compare1 = test_labels(1 : (classIndex - 1)) - predicted_labels(1 : (classIndex - 1));
wrongPredictions1 = nnz(compare1);
per_class_accuracy_1 = (1 - (wrongPredictions1 / length(test_labels(1 : (classIndex - 1))))) * 100;


compare2 = test_labels(classIndex : end) - predicted_labels(classIndex : end);
wrongPredictions2 = nnz(compare2);
per_class_accuracy_2 = (1 - (wrongPredictions2 / length(test_labels(classIndex : end)))) * 100;

% output per class accuracy - two percentages of correct predictions
per_class_accuracy = [per_class_accuracy_1 per_class_accuracy_2];

end