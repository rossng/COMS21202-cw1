% CW1a
% Q2)

clearvars();

% Load and cluster the training data
cluster_training_data();

figure();


% Plot the clusters from rg14820.train with their centroids and voronoi tessellation
subplot(2,1,1);
hold on

plot( class_1_rg(:,1), class_1_rg(:,2), 'r.', 'MarkerSize',12 );
plot( class_2_rg(:,1), class_2_rg(:,2), 'b.', 'MarkerSize',12 );
plot( class_3_rg(:,1), class_3_rg(:,2), 'g.', 'MarkerSize',12 );

plot( centroids_rg14820(:,1),centroids_rg14820(:,2),'kx' ...
    , 'MarkerSize', 15 ...
    , 'LineWidth', 3 ...
);

voronoi( centroids_rg14820(:,1), centroids_rg14820(:,2) );

legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids', 'Location', 'NW');
title('Cluster Assignments - rg14820.train');

hold off


% Plot the clusters from jg14987.train with their centroids and voronoi tessellation
subplot(2,1,2);
hold on

plot( class_1_jg(:,1), class_1_jg(:,2), 'r.', 'MarkerSize',12 );
plot( class_2_jg(:,1), class_2_jg(:,2), 'b.', 'MarkerSize',12 );
plot( class_3_jg(:,1), class_3_jg(:,2), 'g.', 'MarkerSize',12 );

plot( centroids_jg14987(:,1), centroids_jg14987(:,2), 'kx' ...
    , 'MarkerSize', 15 ...
    , 'LineWidth', 3 ...
);

voronoi( centroids_jg14987(:,1), centroids_jg14987(:,2) );

legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids', 'Location', 'NW');
title('Cluster Assignments - jg14987.train')
hold off
