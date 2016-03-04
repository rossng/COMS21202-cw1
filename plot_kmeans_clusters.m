data_rg14820 = load('rg14820.train');
data_jg14987 = load('jg14987.train');

features_rg14820 = horzcat(data_rg14820(:,3), data_rg14820(:,5));
features_jg14987 = horzcat(data_jg14987(:,4), data_jg14987(:,5));

rng(1); % For reproducibility
[idx_rg14820,C_rg14820] = kmeans(features_rg14820, 3);
rng(1); % For reproducibility
[idx_jg14987,C_jg14987] = kmeans(features_jg14987, 3);

figure;
subplot(2,1,1);
hold on
plot(features_rg14820(idx_rg14820==1,1),features_rg14820(idx_rg14820==1,2),'r.','MarkerSize',12)
plot(features_rg14820(idx_rg14820==2,1),features_rg14820(idx_rg14820==2,2),'b.','MarkerSize',12)
plot(features_rg14820(idx_rg14820==3,1),features_rg14820(idx_rg14820==3,2),'g.','MarkerSize',12)
plot(C_rg14820(:,1),C_rg14820(:,2),'kx','MarkerSize',15,'LineWidth',3)

%Plot decision boundary
voronoi(C_rg14820(:,1),C_rg14820(:,2));

legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NW')
title 'Cluster Assignments - rg14820'



hold off

subplot(2,1,2);
hold on
plot(features_jg14987(idx_jg14987==1,1),features_jg14987(idx_jg14987==1,2),'r.','MarkerSize',12)
plot(features_jg14987(idx_jg14987==2,1),features_jg14987(idx_jg14987==2,2),'b.','MarkerSize',12)
plot(features_jg14987(idx_jg14987==3,1),features_jg14987(idx_jg14987==3,2),'g.','MarkerSize',12)
plot(C_jg14987(:,1),C_jg14987(:,2),'kx','MarkerSize',15,'LineWidth',3)

%Plot decision boundary
voronoi(C_jg14987(:,1),C_jg14987(:,2));

legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NW')
title 'Cluster Assignments - jg14987'
hold off