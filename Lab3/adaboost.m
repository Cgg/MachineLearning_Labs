 function [mu, sigma, p, alpha, classes] = adaboost(data, T)


[M,N] = size( data );
w = ones(length( data ),1) .* ( 1/length( data ) );
% p = prior( data, w );
classes  = unique( data( :, end ) );

for t=1:T
    [ tMu tSigma ] = bayes_weight( data, w );
    mu(:,:,t) = tMu;
    sigma(:,:,t) = tSigma;

    p( t, : ) = prior( data, w )
        
    g = discriminant( data( :, 1:N-1 ), tMu, tSigma, p );
    [dummy class] = max( g, [], 2 );
    class = class - 1;
    correct = ( class == data( :, end ) );
    
    e(t) = 1-sum( w.*( correct ) );
    
    alpha(t) = (1/2)*log((1-e(t))/e(t));
    
    w = w.*( exp(-alpha(t))*correct + exp(alpha(t))*(~correct) );
    w = w / sum( w );
end
