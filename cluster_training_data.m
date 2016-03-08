% Load the training data, extract the relevant features, cluster with
% kmeans and split data into the clustered classes

training_data_rg14820 = load('rg14820.train');
training_data_jg14987 = load('jg14987.train');

% Extract only the 'interesting' features from the training data, as
% identified in plot_training_data.m
features_rg14820 = horzcat(training_data_rg14820(:,3), training_data_rg14820(:,5));
features_jg14987 = horzcat(training_data_jg14987(:,4), training_data_jg14987(:,5));

% Cluster both sets of training data into three groups
% idx_ab12345       = indices of the cluster each data item is in
% centroids_ab12345 = the centroids of each cluster

% First, reset the rng so that the kmeans call is reproduceable
rng(1);
[idx_rg14820, centroids_rg14820] = kmeans(features_rg14820, 3);

rng(1);
[idx_jg14987, centroids_jg14987] = kmeans(features_jg14987, 3);

% Use the cluster indices to separate the training data sets into clusters
class_1_rg = [features_rg14820(idx_rg14820==1,1), features_rg14820(idx_rg14820==1,2)];
class_2_rg = [features_rg14820(idx_rg14820==2,1), features_rg14820(idx_rg14820==2,2)];
class_3_rg = [features_rg14820(idx_rg14820==3,1), features_rg14820(idx_rg14820==3,2)];

class_1_jg = [features_jg14987(idx_jg14987==1,1), features_jg14987(idx_jg14987==1,2)];
class_2_jg = [features_jg14987(idx_jg14987==2,1), features_jg14987(idx_jg14987==2,2)];
class_3_jg = [features_jg14987(idx_jg14987==3,1), features_jg14987(idx_jg14987==3,2)];