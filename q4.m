% CW1a
% Q4)

clearvars();

%% Load the 'interesting' features from each training dataset
features_rg = loader.load_columns('rg14820.train', [3 5]);
features_jg = loader.load_columns('jg14987.train', [4 5]);

%% Perform non-optimal clustering on the datasets

% Define some (bad) initial centroid locations for the kmeans algorithm
initial_centroids_rg = [ 3,4 ; 3,4 ; 3,4 ];
initial_centroids_jg = [ 8,5 ; 8,5 ; 8,5 ];

% Cluster the two sets of training data using the bad initial centroids
[idx_rg, centroids_rg] = loader.cluster_data(features_rg, 3 ...
    , 'Start', initial_centroids_rg ...
);

[idx_jg, centroids_jg] = loader.cluster_data(features_jg, 3 ...
    , 'Start' , initial_centroids_jg ...
);

%% Plot the results of the non-optimal clustering

figure();

% Plot the clusters from rg14820.train with their centroids and voronoi tessellation
subplot(2,1,1);
hold on

plot( features_rg(idx_rg==1,1), features_rg(idx_rg==1,2), 'r.', 'MarkerSize',12 );
plot( features_rg(idx_rg==2,1), features_rg(idx_rg==2,2), 'b.', 'MarkerSize',12 );
plot( features_rg(idx_rg==3,1), features_rg(idx_rg==3,2), 'g.', 'MarkerSize',12 );

plot( centroids_rg(:,1),centroids_rg(:,2), 'kx' ...
    , 'MarkerSize', 15 ...
    , 'LineWidth', 3 ...
);

voronoi( centroids_rg(:,1), centroids_rg(:,2) );

legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids', 'Location', 'NW');
title('Bad cluster Assignments - rg14820.train');

hold off


% Plot the clusters from jg14987.train with their centroids and voronoi tessellation
subplot(2,1,2);
hold on

plot( features_jg(idx_jg==1,1), features_jg(idx_jg==1,2), 'r.', 'MarkerSize',12 );
plot( features_jg(idx_jg==2,1), features_jg(idx_jg==2,2), 'b.', 'MarkerSize',12 );
plot( features_jg(idx_jg==3,1), features_jg(idx_jg==3,2), 'g.', 'MarkerSize',12 );

plot( centroids_jg(:,1),centroids_jg(:,2), 'kx' ...
    , 'MarkerSize', 15 ...
    , 'LineWidth', 3 ...
);

voronoi( centroids_jg(:,1), centroids_jg(:,2) );

legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids', 'Location', 'NW');
title('Bad cluster Assignments - jg14987.train');

hold off