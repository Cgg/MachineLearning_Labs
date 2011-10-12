function [ mu, sigma ] = bayes_weight( data, w )

%% BAYES_WEIGHT function
% Computes and returns the maximum posterior (MAP) parameters μ* σ* for a 
% given dataset D with weighted instances. It is the same function as
% bayes.m with the difference that it deals with fractional (weighted)
% instances of data.

% It takes as input the dataset 'data' and the weight vector w.

% The dataset is a matrix with 3 columns:
% data(row_index, 1) is the r_norm value of the pixel
% data(row_index, 2) is the g_norm value of the pixel
% data(row_index, 3) is the class of the pixel, 0 for 'hand' and 1 for
% 'book'

% The weight vector w is an Mx1 vectro where M is the number of instances
% of data in the dataset. w[k] has a weight for the data[k] instance.

% It returns 2 matrices: mu matrix and sigma matrix which are the maximum
% posterior (MAP) parameters for the dataset. In both matrices indexing is
% as follows:
% mu(i,j) --> i gives the class (1 for 'hand' and 2 for 'book')
%         --> j gives the parameter/feature (1 for r_norm and 2 for g_norm)


%% Calculation of mu matrix

% Initialization of variables and matrix mu. In notation we follow the mu
% matrix indexing notation described above in the function description.

M1 = 0;
M2 = 0;
mu = zeros(2);
sum11 = 0;
sum12 = 0;
sum21 = 0;
sum22 = 0;


% Loop for calculating the necessary sum.

for count = 1:length(data)
    if data(count, 3) == 0 % Hand class
        M1 = M1 + w(count);
        sum11 = sum11 + ( data(count, 1) * w(count) ); 
        sum12 = sum12 + ( data(count, 2) * w(count) );
        
    elseif data(count, 3) == 1 % Book class
        M2 = M2 + w(count);
        sum21 = sum21 + ( data(count, 1) * w(count) ); 
        sum22 = sum22 + ( data(count, 2) * w(count) );
    end
end
   
mu(1, 1) = sum11 / M1;
mu(1, 2) = sum12 / M1;
mu(2, 1) = sum21 / M2;
mu(2, 2) = sum22 / M2;


%% Calculation of sigma matrix

% Initialization of variables and matrix mu. In notation we follow the mu
% matrix indexing notation described above in the function description.

sum_11 = 0;
sum_12 = 0;
sum_21 = 0;
sum_22 = 0;
sigma = zeros(2);

% Loop for calculating the necessary sum.

for countt = 1:length(data)
    if data(countt, 3) == 0 % Hand class
        sum_11 = sum_11 + ( w(count)*( data(countt, 1) - mu(1, 1) ) ^ 2 ); 
        sum_12 = sum_12 + ( w(count)*( data(countt, 2) - mu(1, 2) ) ^ 2 );
    elseif data(countt, 3) == 1 % Book class
        sum_21 = sum_21 + ( w(count)*( data(countt, 1) - mu(2, 1) ) ^ 2 ); 
        sum_22 = sum_22 + ( w(count)*( data(countt, 2) - mu(2, 2) ) ^ 2 );
    end
end

sigma(1, 1) = sqrt( sum_11 / M1 );
sigma(1, 2) = sqrt( sum_12 / M1 );
sigma(2, 1) = sqrt( sum_21 / M2 );
sigma(2, 2) = sqrt( sum_22 / M2 );


end

