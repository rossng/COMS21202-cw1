data_rg14820 = load('rg14820.train');
data_jg14987 = load('jg14987.train');

training_features_rg14820 = horzcat(data_rg14820(:,3), data_rg14820(:,5));
training_features_jg14987 = horzcat(data_jg14987(:,4), data_jg14987(:,5));

rng(1); % For reproducibility
[idx_rg14820,centroids_rg14820] = kmeans(training_features_rg14820, 3);
rng(1); % For reproducibility
[idx_jg14987,centroids_jg14987] = kmeans(training_features_jg14987, 3);

test_rg14820 = load('rg14820.test');
test_jg14987 = load('jg14987.test');

test_features_rg14820 = horzcat(test_rg14820(:,3), test_rg14820(:,5));
test_features_jg14987 = horzcat(test_jg14987(:,4), test_jg14987(:,5));

dist_rg14820 = pdist2(centroids_jg14987, test_features_rg14820);
dist_jg14987 = pdist2(centroids_jg14987, test_features_jg14987);

[min_dist_rg14820,min_dist_indices_rg14820] = min(dist_rg14820);
[min_dist_jg14987,min_dist_indices_jg14987] = min(dist_jg14987);

