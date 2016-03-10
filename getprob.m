function P = getprob(x, y, mu, sigma)
% GETPROB   Compute the probability of the result (x, y) in a bivariate
% normal distribution parameterised by mean mu and covariance matrix sigma.
    
    vec = [x y]';
            
    P = (vec-mu')' * inv(sigma) * (vec-mu') / 2 ;
    
end

