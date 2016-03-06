function P = levelfunction( x ,y, mu, sigma)
    
    vec = [x y]';
       
            
    P = (vec-mu')' * inv(sigma) * (vec-mu') / 2 ;
    
end

