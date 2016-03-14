% CW1a
% Q4)

clearvars();

%% Load the 'interesting' features from each training dataset
features_rg = loader.load_columns('rg14820.train', [3 5]);
features_jg = loader.load_columns('jg14987.train', [4 5]);

%% Perform non-optimal clustering on the datasets

% Define some (bad) initial centroid locations for the kmeans algorithm
centroids_rg = [ 3,4 ; 3,4 ; 3,4 ];
centroids_jg = [ 3,4; 3,6 ; 5,10 ]; %%% TODO: find non-optimal clustering

% Generate random initial centroids - still fails to produce a non-optimal
% clustering for jg, left in for reference
% rng('shuffle');
% centroids_jg = randi([0 10],3,2);
% c = centroids_jg;

% Cluster the two sets of training data using the bad initial centroids

for n = 0:0
    [idx_rg, centroids_rg] = loader.cluster_data(features_rg, 3 ...
        , 'Start', centroids_rg ...
    );

    [idx_jg, centroids_jg] = loader.cluster_data(features_jg, 3 ...
        , 'Start', centroids_jg ...
    );
end
%% Plot the results of the non-optimal clustering

figure();

% Plot the clusters from rg14820.train with their centroids and voronoi tessellation
p1 = subplot(1,2,1);
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
title('Non-optimal Clustering- rg14820.train');

hold off


% Plot the clusters from jg14987.train with their centroids and voronoi tessellation
p2 = subplot(1,2,2);
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
title('Optimal Clustering - jg14987.train');

hold off

axis([p1 p2], [0 10 0 10]);