classdef loader
    %LOADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        
        function out = load_columns(filename, cols)
            % LOAD_COLUMNS  Load data from a file and filter it to only the 
            %               chosen columns.
            %   data = LOAD_COLUMNS('rg14820.train', [3 5]) loads the
            %   rg14820.train file and filters it to just columns 3 and 5.
            
            data = load(filename);
            out = data(:, cols);
        end
        
        function [idx, centroids] = cluster_data(data, num_classes, varargin)
            % CLUSTER_DATA  Given some items of data (one item per row), 
            %               cluster the items in num_classes classes with
            %               kmeans. Deterministic.
            %   [idx, centroids] = CLUSTER_DATA(data, 3) classifies the
            %   items in k-by-m matrix 'data' into three classes. idx is a
            %   k-by-1 matrix containing the calculated class index of each
            %   item. centroids is a 3-by-m matrix containing the
            %   centroids of each class.

            % First, reset the rng so that the kmeans call is reproduceable
            rng(1);
            % Then use kmeans to cluster the data into the chosen number of
            % classes
            [idx, centroids] = kmeans(data, num_classes, varargin{:});
        end
    end
    
end

