% Implement the Adaboost algorithm - which seems to have nothing to do with
% Ada (fortunatly)
%
% mu, sigma and p contain the T sets of MAP parameters and priors

function [ mu, sigma, p, alpha, classes ] = adaboost( data, T )

% diverse inits
M = size( data, 1 );

w = zeros( M, T + 1 );

% init all weights of t = 1 uniformly at 1 / M
w( :, 1 ) = 1 / M;

for t = 1 : T

  % Train weak learner using distribution w(t)
  [ mu( :, :, t ), sigma( :, :, t ) ] = bayes_weight( data, w( :, t ) );

  p( t, : ) = prior( data, w( :, t ) );

  % Get weak hypothesis h_t and compute its error e_t wrt w(t)
  g_t = discriminant( data( :, 1:2 ), mu( :, :, t ), sigma( :, : ,t ),...
                      p( t, : ) );

  [ dummy, class ] = max( g_t, [], 2 );
  class = class - 1;

  e_t = 0;
  for m = 1 : M
    e_t = e_t + w( m, t ) * ( class( m ) == data( m, end ) )
  end

  e_t = 1 - e_t;

  % compute alpha_t
  alpha( t ) = 0.5 * log( ( 1 - e_t ) / e_t );

  for m = 1 : M
    if( class( m ) == data( m, end ) )
      w( m, t + 1 ) = w( m, t ) * exp( - a_t );
    else
      w( m, t + 1 ) = w( m, t ) * exp( a_t );
    end
  end

  % the normalization factor
  w( :, t ) = w( :, t ) / norm( w( :, t ) );

end

classes( 0 ) = 0;
classes( 1 ) = 1; % I dont fully understand that.

end
