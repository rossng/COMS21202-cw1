
classify_test_data

%mean and cov for each class 
mean_jg_1 = mean(class_1_rg);
cov_jg_1 =  cov(class_1_rg);

mean_jg_2 = mean(class_2_rg);
cov_jg_2 =  cov(class_2_rg);

mean_jg_3 = mean(class_3_rg);
cov_jg_3 = cov(class_3_rg);

mean_rg_1 = mean(class_1_rg);
cov_rg_1 =  cov(class_1_rg);

mean_rg_2 = mean(class_2_rg);
cov_rg_2 =  cov(class_2_rg);

mean_rg_3 = mean(class_3_rg);
cov_rg_3 = cov(class_3_rg);


step = 0.01;

%define a set of points we can work from
[x , y] = meshgrid(-2:step:12,-2:step:12);
[r , c] = size(x);

data = [x(:) y(:)];


%calc mvnpdf for each point
p_jg_1 = mvnpdf(data, mean_jg_1 , cov_jg_1);
p_jg_2 = mvnpdf(data, mean_jg_2 , cov_jg_2);
p_jg_3 = mvnpdf(data, mean_jg_3 , cov_jg_3);


p_jg_1 = reshape(p_jg_1, r, c);
p_jg_2 = reshape(p_jg_2, r, c);
p_jg_3 = reshape(p_jg_3, r, c);

%Messy function to calc the contour level
%Uses matlab solve function 
l_jg_1 = calcLevel(mean_rg_1 , cov_rg_1);
l_jg_2 = calcLevel(mean_rg_2 , cov_rg_2);
l_jg_3 = calcLevel(mean_rg_3 , cov_rg_3);


%Repeated again for RG data

p_rg_1 = mvnpdf(data, mean_rg_1 , cov_rg_1);
p_rg_2 = mvnpdf(data, mean_rg_2 , cov_rg_2);
p_rg_3 = mvnpdf(data, mean_rg_3 , cov_rg_3);


p_rg_1 = reshape(p_rg_1, r, c);
p_rg_2 = reshape(p_rg_2, r, c);
p_rg_3 = reshape(p_rg_3, r, c);

%Messy function to calc the contour level
%Uses matlab solve function 
l_rg_1 = calcLevel(mean_rg_1 , cov_rg_1);
l_rg_2 = calcLevel(mean_rg_2 , cov_rg_2);
l_rg_3 = calcLevel(mean_rg_3 , cov_rg_3);



subplot(2,1,2);
hold on
contour( x , y, p_jg_1, [l_jg_1 l_jg_1] );
contour( x , y, p_jg_2, [l_jg_2 l_jg_2] );
contour( x , y, p_jg_3, [l_jg_3 l_jg_3] );
hold off

subplot(2,1,1);
hold on
contour( x , y, p_rg_1, [l_rg_1 l_rg_1] );
contour( x , y, p_rg_2, [l_rg_2 l_rg_2] );
contour( x , y, p_rg_3, [l_rg_3 l_rg_3] );
hold off

