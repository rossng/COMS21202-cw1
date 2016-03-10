function point = find_point_at_mahal_dist(squared_mahal_dist, mu, sigma)
%Takes existing point (mu_x) and calculates 
%Another point y that will be in the ellipse

    syms y;
    
    v = solve( mahal_dist([mu(1), y], mu, sigma)^2 == squared_mahal_dist, y );
    v = double(v(1));
    
    point = [mu(1) v];       
        
end

