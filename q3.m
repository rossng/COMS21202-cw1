% CW1a
% Q3)

clearvars();

% Obtain the cluster centroids: centroids_jg14987 and centroids_rg14820
cluster_training_data();

% Load the test data and extract the useful columns
test_data_jg14987 = load('jg14987.test');
test_data_rg14820 = load('rg14820.test');

features_test_jg14987 = horzcat(test_data_jg14987(:,4), test_data_jg14987(:,5));
features_test_rg14820 = horzcat(test_data_rg14820(:,3), test_data_rg14820(:,5));


% Calculate the euclidean distance of each item of test data from each
% centroid
distances_jg14987 = pdist2(centroids_jg14987, features_test_jg14987, 'euclidean');
distances_rg14820 = pdist2(centroids_rg14820, features_test_rg14820, 'euclidean');

% Find the minimum distance for each data item to get the index of its
% nearest centroid - i.e. the class of each data item
[~, nearest_centroid_idx_jg] = min(distances_jg14987, [], 1);
[~, nearest_centroid_idx_rg] = min(distances_rg14820, [], 1);

% Use the nearest centroid indices to separate the test data into classes
class_1_jg_test = features_test_jg14987(nearest_centroid_idx_jg(end,:) == 1, :);
class_2_jg_test = features_test_jg14987(nearest_centroid_idx_jg(end,:) == 2, :);
class_3_jg_test = features_test_jg14987(nearest_centroid_idx_jg(end,:) == 3, :);

class_1_rg_test = features_test_rg14820(nearest_centroid_idx_rg(end,:) == 1, :);
class_2_rg_test = features_test_rg14820(nearest_centroid_idx_rg(end,:) == 2, :);
class_3_rg_test = features_test_rg14820(nearest_centroid_idx_rg(end,:) == 3, :);


% Now plot the results of the clustering
figure();

subplot(2,1,2);
hold on

plot( class_1_jg_test(:,1), class_1_jg_test(:,2), 'rx' ...
    , 'MarkerSize',12 ...
);
plot( class_2_jg_test(:,1), class_2_jg_test(:,2), 'bx' ...
    , 'MarkerSize',12 ...
);
plot( class_3_jg_test(:,1), class_3_jg_test(:,2), 'gx' ...
    , 'MarkerSize',12 ...
);

hold off


subplot(2,1,1);
hold on

plot( class_1_rg_test(:,1), class_1_rg_test(:,2), 'rx' ...
    , 'MarkerSize',12 ...
);
plot( class_2_rg_test(:,1), class_2_rg_test(:,2), 'bx' ...
    , 'MarkerSize',12 ...
);
plot( class_3_rg_test(:,1), class_3_rg_test(:,2), 'gx' ...
    , 'MarkerSize',12 ...
);

hold off
