function g = discriminant( data, mu, sigma, p )
%% DISCRIMINANT computes the discriminant functions gi
% Takes as input the dataset, the mu and sigma matrices and vector p

% data is a matrix with 2 columns:
% data(row_index, 1) is the r_norm value of the pixel
% data(row_index, 2) is the g_norm value of the pixel

% mu and sigma matrices have ixN dimensions, where i is the number of
% classes and N the number of features of the dataset. For our example
% they are 2x2. (for further info look at bayes.m)

% p is a 1xi vector, where i is the number of classes (2 for our problem)

% Returns the discriminant matrix g which is of Mxi dimensions. M is the 
% number of our data (length of the data matrix) and i is the number of
% classes. In our example it is an Mx2 matrix

%% Calculation of g functions
% index i refers to the number of classes
% note that log is natural logarithm in matlab and the lab

for count = 1:length(data)
    for i = 1:2
        g(count, i) = log( p(1, i) ) - ... 
        log( sigma(i, 1) ) - log( sigma(i, 2) ) - ...
      (( data(count, 1) - mu(i, 1) ) ^ 2 / ( 2 * sigma(i, 1) ^ 2 )) - ...
      (( data(count, 2) - mu(i, 2) ) ^ 2 / ( 2 * sigma(i, 2) ^ 2 ));
    end
end
