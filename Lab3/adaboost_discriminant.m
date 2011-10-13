function c = adaboost_discriminant (data, mu, sigma, p, alpha, classes, T)




[M N] = size(data);

candidates= zeros(M, length(classes) );

for i = 1: length(classes)
    for t = 1: T  
        g = discriminant(data, mu(:,:,t), sigma(:,:,t), p);
        [dummy class] = max(g, [], 2);
        class = class - 1;
        candidates(:,i) = candidates(:,i) + alpha(t) * ...
            (class == classes(i))  ; 
    
    end 

    
end

[dummy I] = max(candidates, [], 2 );

c = I - 1;
