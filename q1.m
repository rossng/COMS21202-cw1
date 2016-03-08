% CW1a
% Q1)

clearvars();

% Load and plot the 5-dimensional training data
data_rg14820 = load('rg14820.train');
data_jg14987 = load('jg14987.train');

figure();

subplot(2,1,1);
plotmatrix(data_rg14820);
title('rg14820.train')

subplot(2,1,2);
plotmatrix(data_jg14987);
title('jg14987.train')

% We can now use the plots to identify the features which separate the 
% clusters in the data:

% interesting columns in rg14820: 3, 5
% interesting columns in jg14987: 4, 5
