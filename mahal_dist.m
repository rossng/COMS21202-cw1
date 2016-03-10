function dist = mahal_dist(X, mu, sigma)
% MAHAL_DIST   Compute the Mahalanobis distance of observation X from a
% distribution with mean mu and covariance matrix sigma
%   MAHAL_DIST([4 4], [1 1], [1 -0.5; 1 -0.5]) = 
            
    dist = sqrt((X - mu) * inv(sigma) * (X - mu)');
    
end

