%% Machine Learning Lab 3
% Bayes Classifier and Boosting

%% Setup

clear

%% Read images

hand = imread('hand.ppm','ppm');
book = imread('book.ppm','ppm');
imagesc(hand);
figure;
imagesc(book);

%% Viewing data

data1 = normalize_and_label(hand, 0);
data2 = normalize_and_label(book, 1);
test_data = [data1; data2];
figure;
hold on;
plot(data2(:,1), data2(:,2), '.');
plot(data1(:,1), data1(:,2), '.r');
legend('Hand holding book', 'Hand');
xlabel('green');
ylabel('red')

%% Assignment 1

% Calculation of mu and sigma parameters (MAP parameters) for the dataset
% by calling bayes function.

clc;
[mu sigma] = bayes(test_data)

% Plot a 95%-confidence interval to verify that our estimations match the
% data

theta = [0 : 0.01 : 2*pi];
x1 = 2*sigma(1, 1) * cos(theta) + mu(1, 1);
y1 = 2*sigma(1, 2) * sin(theta) + mu(1, 2);
x2 = 2*sigma(2, 1) * cos(theta) + mu(2, 1);
y2 = 2*sigma(2, 2) * sin(theta) + mu(2, 2);
plot(x1, y1, 'r');
plot(x2, y2);

%% Assignment 2

% Train the Bayes classifier with test_data dataset

[M N] = size(test_data);
p = prior(test_data);
g = discriminant(test_data(:, 1:2), mu, sigma, p)

% Compute classification error

[dummy class] = max(g, [], 2);
class = class -1;
error_test = 1.0 - sum(class == test_data(:, end)) / M

% Overlay the deciion boundary X = {x : g0 (x) = g1 (x)} that seperates
% both classes

ax = [ 0.2 0.5 0.2 0.45 ];
axis( ax );
x = ax( 1 ) : 0.01 : ax( 2 );
y = ax( 3 ) : 0.01 : ax( 4 );
[ z1 z2 ] = meshgrid( x, y );
z1 = reshape( z1, size( z1, 1 ) * size( z1, 2 ), 1 );
z2 = reshape( z2, size( z2, 1 ) * size( z2, 2 ), 1 );
g = discriminant( [ z1 z2 ], mu, sigma, p );
gg = g( :, 1 ) - g( :, 2 );
gg = reshape( gg, length( y ), length( x ) );
[ c, h ] = contour( x, y, gg, [ 0.0 0.0 ] );
set( h, 'LineWidth', 3 );

% Normalize the image 'hand holding book'

book_rg = zeros( size( book, 1 ), size( book, 2 ), 2 );
for y = 1 : size( book, 1 )
    for x = 1 : size( book, 2 )
        s = sum( book( y, x, : ) );
        if ( s > 0 )
            book_rg( y, x, : ) = [ double( book( y, x, 1) ) / s double(...
                book( y, x, 2 ) ) / s ];
        end
    end
end

% Classify all pixels in the image

tmp = reshape( book_rg, size( book_rg, 1 ) * size( book_rg, 2 ), 2 );
g = discriminant( tmp, mu, sigma, p );
gg = g( :, 1) - g( :, 2);
gg = reshape( gg, size( book_rg, 1 ), size( book_rg, 2 ) );

% Create a mask of all the pixels that are classified to belong to the
% 'hand' image

mask = gg < 0;
mask3D( :, :, 1 ) = mask;
mask3D( :, :, 2 ) = mask;
mask3D( :, :, 3 ) = mask;

% Aply the mask to the 'hand holding book' image

result_im = uint8( double( book ) .* mask3D );
figure;
imagesc( result_im );
