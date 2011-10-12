%% Machine Learning Lab 3
% Verification code. Results should agree with bb-help.pdf

%% Create verification dataset
% We create the test_data from the saved variables data1t and data2t given
% at varification_data.mat

test_data = [data1t; data2t];

%% Assignment 1 & 2

% Calculation of mu and sigma parameters (MAP parameters) for the dataset
% by calling bayes function.

[mu sigma] = bayes(test_data)

[M N] = size(test_data);
p = prior(test_data)
g = discriminant(test_data(:, 1:2), mu, sigma, p)
[dummy class] = max(g, [], 2);
class = class -1;
error_test = 1.0 - sum(class == test_data(:, end)) / M



