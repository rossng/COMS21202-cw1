% CW1a
% Q2)

clearvars();

% Load the 'interesting' features from each training dataset
features_rg = loader.load_columns('rg14820.train', [3 5]);
features_jg = loader.load_columns('jg14987.train', [4 5]);

% Cluster both sets of training data into three groups
[idx_rg, centroids_rg] = loader.cluster_data(features_rg, 3);
[idx_jg, centroids_jg] = loader.cluster_data(features_jg, 3);


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
title('Cluster Assignments - rg14820.train');

hold off


% Plot the clusters from jg14987.train with their centroids and voronoi tessellation
p2 = subplot(1,2,2);
hold on

plot( features_jg(idx_jg==1,1), features_jg(idx_jg==1,2), 'r.', 'MarkerSize',12 );
plot( features_jg(idx_jg==2,1), features_jg(idx_jg==2,2), 'b.', 'MarkerSize',12 );
plot( features_jg(idx_jg==3,1), features_jg(idx_jg==3,2), 'g.', 'MarkerSize',12 );

plot( centroids_jg(:,1), centroids_jg(:,2), 'kx' ...
    , 'MarkerSize', 15 ...
    , 'LineWidth', 3 ...
);

voronoi( centroids_jg(:,1), centroids_jg(:,2) );

legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids', 'Location', 'NW');
title('Cluster Assignments - jg14987.train')
hold off

axis([p1 p2], [0 10 0 10]);
