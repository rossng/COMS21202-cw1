% CW1a
% Q3)

clearvars();

%% Load the training and test datasets
% Load the 'interesting' features from each training dataset
features_rg = loader.load_columns('rg14820.train', [3 5]);
features_jg = loader.load_columns('jg14987.train', [4 5]);
% Load the 'interesting' features from each test dataset
features_test_rg = loader.load_columns('rg14820.test', [3 5]);
features_test_jg = loader.load_columns('jg14987.test', [4 5]);

%% Cluster the training dataset
% Cluster both sets of training data into three groups
[idx_rg, centroids_rg] = loader.cluster_data(features_rg, 3);
[idx_jg, centroids_jg] = loader.cluster_data(features_jg, 3);

%% Determine the nearest-neighbour centroids for each item of test data
% Calculate the euclidean distance of each item of test data from each
% centroid
dists_jg = pdist2(centroids_jg, features_test_jg, 'euclidean');
dists_rg = pdist2(centroids_rg, features_test_rg, 'euclidean');

% Find the minimum distance for each data item to get the index of its
% nearest centroid - i.e. the class of each data item
[~, idx_jg_test] = min(dists_jg, [], 1);
[~, idx_rg_test] = min(dists_rg, [], 1);

%% Now plot the test data classified by nearest-neighbour centroid
figure();

plot_classes();

subplot(1,2,2);
hold on

plot( features_test_jg(idx_jg_test==1,1), features_test_jg(idx_jg_test==1,2) ...
    , 'rx' ...
    , 'MarkerSize',12 ...
);
plot( features_test_jg(idx_jg_test==2,1), features_test_jg(idx_jg_test==2,2) ...
    , 'bx' ...
    , 'MarkerSize',12 ...
);
plot( features_test_jg(idx_jg_test==3,1), features_test_jg(idx_jg_test==3,2) ...
    , 'gx' ...
    , 'MarkerSize',12 ...
);

title('Nearest-neighbour Classification - jg14987.test');

hold off


subplot(1,2,1);
hold on

plot( features_test_rg(idx_rg_test==1,1), features_test_rg(idx_rg_test==1,2) ...
    , 'rx' ...
    , 'MarkerSize',12 ...
);
plot( features_test_rg(idx_rg_test==2,1), features_test_rg(idx_rg_test==2,2) ...
    , 'bx' ...
    , 'MarkerSize',12 ...
);
plot( features_test_rg(idx_rg_test==3,1), features_test_rg(idx_rg_test==3,2) ...
    , 'gx' ...
    , 'MarkerSize',12 ...
);

title('Nearest-neighbour Classification - rg14820.test');

hold off
