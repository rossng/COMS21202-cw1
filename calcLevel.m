function level = calcLevel( mu , sigma )
%Takes existing point (mu_x) and calculates 
%Another point y that will be in the ellipse


    syms b;
    
    class_mu_x = mu(1);
    
    v = solve ( levelfunction(class_mu_x,b,mu, sigma ) == 3, b);
    v = double(v(1));
    
    level = mvnpdf([class_mu_x v], mu , sigma);
        
        
end

