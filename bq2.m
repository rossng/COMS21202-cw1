clearvars()

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

%% Generate Mesh
step = 0.05;
[x, y] = meshgrid( -2:step:12, -2:step:12 );
[r, c] = size(x);

mvnpdf_sampling_mesh = [x(:) y(:)];


%%
% Use the inferred means and covariances of each cluster to determine the
% probability density of the cluster at every point in the sampling mesh
pd_jg_1 = mvnpdf(mvnpdf_sampling_mesh, mean_jg_1, cov_jg_1);
pd_jg_2 = mvnpdf(mvnpdf_sampling_mesh, mean_jg_2, cov_jg_2);
pd_jg_3 = mvnpdf(mvnpdf_sampling_mesh, mean_jg_3, cov_jg_3);

% Reshape the single-column output from mvnpdf into a matrix of probability
% densities
pd_jg_1 = reshape(pd_jg_1, r, c);
pd_jg_2 = reshape(pd_jg_2, r, c);
pd_jg_3 = reshape(pd_jg_3, r, c);



%%
% We want to draw a contour containing 95% of the probability mass of the
% class. First, we determine the probability density within which 95% of
% the mass exists.
pd_boundary_jg_1 = calc_level(mean_rg_1, cov_rg_1);
pd_boundary_jg_2 = calc_level(mean_rg_2, cov_rg_2);
pd_boundary_jg_3 = calc_level(mean_rg_3, cov_rg_3);

LR_jg_1_2 = pd_jg_1./pd_jg_2;
LR_jg_1_3 = pd_jg_1./pd_jg_3;
LR_jg_2_3 = pd_jg_2./pd_jg_3;

subplot(2,1,2);
hold on

contour( x, y, pd_jg_1, [pd_boundary_jg_1 pd_boundary_jg_1] );
contour( x, y, pd_jg_2, [pd_boundary_jg_2 pd_boundary_jg_2] );
contour( x, y, pd_jg_3, [pd_boundary_jg_3 pd_boundary_jg_3] );

contour( x, y, LR_jg_1_2, [1 1] );
contour( x, y, LR_jg_1_3, [1 1] );
contour( x, y, LR_jg_2_3, [1 1] );

hold off