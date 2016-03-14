%% CW1b
%  Q1)
clearvars();

%% Load the training and test datasets
% Load the 'interesting' features from each training dataset
features_rg = loader.load_columns('rg14820.train', [3 5]);
features_jg = loader.load_columns('jg14987.train', [4 5]);

%% Cluster the training dataset
% Cluster both sets of training data into three groups
[idx_rg, centroids_rg] = loader.cluster_data(features_rg, 3);
[idx_jg, centroids_jg] = loader.cluster_data(features_jg, 3);

%% Calculate the mean and covariances for the data in each class
mean_jg_1 = mean( features_jg(idx_jg==1,:) );
cov_jg_1 =  cov( features_jg(idx_jg==1,:) );

mean_jg_2 = mean( features_jg(idx_jg==2,:) );
cov_jg_2 =  cov( features_jg(idx_jg==2,:) );

mean_jg_3 = mean( features_jg(idx_jg==3,:) );
cov_jg_3 =  cov( features_jg(idx_jg==3,:) );

mean_rg_1 = mean( features_rg(idx_rg==1,:) );
cov_rg_1 =  cov( features_rg(idx_rg==1,:) );

mean_rg_2 = mean( features_rg(idx_rg==2,:) );
cov_rg_2 =  cov( features_rg(idx_rg==2,:) );

mean_rg_3 = mean( features_rg(idx_rg==3,:) );
cov_rg_3 =  cov( features_rg(idx_rg==3,:) );

%% Calculate boundary probability densities

% We want to draw a contour delineating the area which contains 95% of the 
% probability mass of each class

% 1) First, we find (arbitrary) points which have squared mahalanobis
% distance 6 from the centre of each class. (The area with 95% probability
% mass contains all points with mahalanobis distance <= 6)

mahal_dist = chi2inv(0.95, 2);

boundary_point_jg_1 = find_point_at_mahal_dist(mahal_dist, mean_jg_1, cov_jg_1);
boundary_point_jg_2 = find_point_at_mahal_dist(mahal_dist, mean_jg_2, cov_jg_2);
boundary_point_jg_3 = find_point_at_mahal_dist(mahal_dist, mean_jg_3, cov_jg_3);

boundary_point_rg_1 = find_point_at_mahal_dist(mahal_dist, mean_rg_1, cov_rg_1);
boundary_point_rg_2 = find_point_at_mahal_dist(mahal_dist, mean_rg_2, cov_rg_2);
boundary_point_rg_3 = find_point_at_mahal_dist(mahal_dist, mean_rg_3, cov_rg_3);

% 2) We then calculate the probability density of the bivariate distribution
% at each of these points.
boundary_pd_jg_1 = mvnpdf(boundary_point_jg_1, mean_jg_1, cov_jg_1);
boundary_pd_jg_2 = mvnpdf(boundary_point_jg_2, mean_jg_2, cov_jg_2);
boundary_pd_jg_3 = mvnpdf(boundary_point_jg_3, mean_jg_3, cov_jg_3);

boundary_pd_rg_1 = mvnpdf(boundary_point_rg_1, mean_rg_1, cov_rg_1);
boundary_pd_rg_2 = mvnpdf(boundary_point_rg_2, mean_rg_2, cov_rg_2);
boundary_pd_rg_3 = mvnpdf(boundary_point_rg_3, mean_rg_3, cov_rg_3);

%% Calculate probability density meshes for each class

% Create a mesh over which we can evaluate the probability densities of
% each class
step = 0.05;
[x, y] = meshgrid( -2:step:12, -2:step:12 );
[r, c] = size(x);

mvnpdf_sampling_mesh = [x(:) y(:)];

% Calculate the probability density across the entire sampling mesh

% 1) Use mvnpdf to calculate the probability densities, producing 
% single-col outputs
pd_jg_1 = mvnpdf(mvnpdf_sampling_mesh, mean_jg_1, cov_jg_1);
pd_jg_2 = mvnpdf(mvnpdf_sampling_mesh, mean_jg_2, cov_jg_2);
pd_jg_3 = mvnpdf(mvnpdf_sampling_mesh, mean_jg_3, cov_jg_3);

pd_rg_1 = mvnpdf(mvnpdf_sampling_mesh, mean_rg_1, cov_rg_1);
pd_rg_2 = mvnpdf(mvnpdf_sampling_mesh, mean_rg_2, cov_rg_2);
pd_rg_3 = mvnpdf(mvnpdf_sampling_mesh, mean_rg_3, cov_rg_3);

% 2) Reshape the single-column outputs from mvnpdf into matrices
pd_jg_1 = reshape(pd_jg_1, r, c);
pd_jg_2 = reshape(pd_jg_2, r, c);
pd_jg_3 = reshape(pd_jg_3, r, c);

pd_rg_1 = reshape(pd_rg_1, r, c);
pd_rg_2 = reshape(pd_rg_2, r, c);
pd_rg_3 = reshape(pd_rg_3, r, c);

%% Draw contours at the calculated 95% boundary densities using the sampling meshes

figure();

plot_classes();

p1 = subplot(1,2,1);
hold on
contour( x, y, pd_jg_1, [boundary_pd_jg_1 boundary_pd_jg_1] );
contour( x, y, pd_jg_2, [boundary_pd_jg_2 boundary_pd_jg_2] );
contour( x, y, pd_jg_3, [boundary_pd_jg_3 boundary_pd_jg_3] );

title('95% Boundaries using Bivariate Normal Distributions - jg14987');
hold off

p2 = subplot(1,2,2);
hold on
contour( x, y, pd_rg_1, [boundary_pd_rg_1 boundary_pd_rg_1] );
contour( x, y, pd_rg_2, [boundary_pd_rg_2 boundary_pd_rg_2] );
contour( x, y, pd_rg_3, [boundary_pd_rg_3 boundary_pd_rg_3] );

title('95% Boundaries using Bivariate Normal Distributions - rg14820');
hold off

axis([p1 p2], [0 10 0 10]);