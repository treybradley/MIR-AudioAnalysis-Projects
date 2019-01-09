% Trey Bradley
% October 8, 2018
% MIR - Assignment 3_Implementation 5


function [predicted_labels] = predict_labels(train_features, train_labels, test_features)

% compute dot products between test feature vectors and training feature
% vectors. the largest dot product is chosen and its location is output.

% tanspose test feature matrix and matrix multiply ... the result represents dot products between
% rows in test feature matrix and columns in train feature matrix
dp = test_features' * train_features;

% find the location of the maximum values of each row - no need to output max value
[~ , location] = max(dp,[],2);

% use location indeces and the label vector to determine which class the chosen max dot product belongs to
predicted_labels = train_labels(location);

end