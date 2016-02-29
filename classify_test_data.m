plot_kmeans_clusters

test_data_jg14987 = load('jg14987.test');
test_data_rg14820 = load('rg14820.test');

features_test_jg14987 = horzcat(test_data_jg14987(:,4), test_data_jg14987(:,5));
features_test_rg14820 = horzcat(test_data_rg14820(:,3), test_data_rg14820(:,5));


D_jg14987 = pdist2(C_jg14987,features_test_jg14987,'euclidean');
D_rg14820 = pdist2(C_rg14820,features_test_rg14820,'euclidean');

[a_jg , b_jg]  = min( D_jg14987 , [] , 1);
[a_rg , b_rg]  = min( D_rg14820 , [] , 1);

classifier_jg = transpose(b_jg);
classifier_rg = transpose(b_rg);

class_1_jg = features_test_jg14987(classifier_jg(:,end) == 1, :);
class_2_jg = features_test_jg14987(classifier_jg(:,end) == 2, :);
class_3_jg = features_test_jg14987(classifier_jg(:,end) == 3, :);

class_1_rg = features_test_rg14820(classifier_rg(:,end) == 1, :);
class_2_rg = features_test_rg14820(classifier_rg(:,end) == 2, :);
class_3_rg = features_test_rg14820(classifier_rg(:,end) == 3, :);

subplot(2,1,2);
hold on
plot(class_1_jg(:,1) , class_1_jg(:,2) ,'rx','MarkerSize',12)
plot(class_2_jg(:,1) , class_2_jg(:,2) ,'bx','MarkerSize',12)
plot(class_3_jg(:,1) , class_3_jg(:,2) ,'gx','MarkerSize',12)
hold off

subplot(2,1,1);

hold on
plot(class_1_rg(:,1) , class_1_rg(:,2) ,'rx','MarkerSize',12)
plot(class_2_rg(:,1) , class_2_rg(:,2) ,'bx','MarkerSize',12)
plot(class_3_rg(:,1) , class_3_rg(:,2) ,'gx','MarkerSize',12)
hold off
