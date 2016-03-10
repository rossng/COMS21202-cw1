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

id = [1,0;0,1];

mean_jg_1 = mean( features_jg(idx_jg==1,:) );
cov_jg_1 =  ( id );

mean_jg_2 = mean( features_jg(idx_jg==2,:) );
cov_jg_2 =  ( id );

mean_jg_3 = mean( features_jg(idx_jg==3,:) );
cov_jg_3 =   id ;

mean_rg_1 = mean( features_rg(idx_rg==1,:) );
cov_rg_1 =  ( id );

mean_rg_2 = mean( features_rg(idx_rg==2,:) );
cov_rg_2 =  ( id );

mean_rg_3 = mean( features_rg(idx_rg==3,:) );
cov_rg_3 =  ( id );

%% Calculate boundary probability densities

% We want to draw a contour delineating the area which contains 95% of the 
% probability mass of each class

% 1) First, we find (arbitrary) points which have squared mahalanobis
% distance 6 from the centre of each class. (The area with 95% probability
% mass contains all points with mahalanobis distance <= 6)
boundary_point_jg_1 = find_point_at_mahal_dist(6, mean_jg_1, cov_jg_1);
boundary_point_jg_2 = find_point_at_mahal_dist(6, mean_jg_2, cov_jg_2);
boundary_point_jg_3 = find_point_at_mahal_dist(6, mean_jg_3, cov_jg_3);

boundary_point_rg_1 = find_point_at_mahal_dist(6, mean_rg_1, cov_rg_1);
boundary_point_rg_2 = find_point_at_mahal_dist(6, mean_rg_2, cov_rg_2);
boundary_point_rg_3 = find_point_at_mahal_dist(6, mean_rg_3, cov_rg_3);

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


%%Calc ratios

LR_jg_1_2 = pd_jg_1./max(pd_jg_2, pd_jg_3);
LR_jg_1_3 = pd_jg_1./max(pd_jg_3, pd_jg_2);
LR_jg_2_3 = pd_jg_2./max(pd_jg_3, pd_jg_1);

LR_rg_1_2 = pd_rg_1./max(pd_rg_2,pd_rg_3);
LR_rg_1_3 = pd_rg_2./max(pd_rg_3,pd_rg_1);
LR_rg_2_3 = pd_rg_3./max(pd_rg_2,pd_rg_1);

%% Draw contours at the calculated 95% boundary densities using the sampling meshes



figure();

plot_classes

subplot(2,1,1);
hold on

contour( x, y, pd_jg_1, [boundary_pd_jg_1 boundary_pd_jg_1] );
contour( x, y, pd_jg_2, [boundary_pd_jg_2 boundary_pd_jg_2] );
contour( x, y, pd_jg_3, [boundary_pd_jg_3 boundary_pd_jg_3] );

title('95% boundaries - jg14987');

contour( x, y, LR_jg_1_2, [1 1] );
contour( x, y, LR_jg_1_3, [1 1] );
contour( x, y, LR_jg_2_3, [1 1] );

hold off




subplot(2,1,2);
hold on
contour( x, y, pd_rg_1, [boundary_pd_rg_1 boundary_pd_rg_1] );
contour( x, y, pd_rg_2, [boundary_pd_rg_2 boundary_pd_rg_2] );
contour( x, y, pd_rg_3, [boundary_pd_rg_3 boundary_pd_rg_3] );

contour( x, y, LR_rg_1_2, [1 1] );
contour( x, y, LR_rg_1_3, [1 1] );
contour( x, y, LR_rg_2_3, [1 1] );


title('95% boundaries - rg14820');
hold off


