function [X,idx,c, V] = FindK(n, csize, d, d2, iterations)
  %function [Metric] = sumDistancesToCenter(clusterId,clustering,centers)
  X = Graph(n,csize,d,d2);
  V = [];
  for i = 1:iterations
    [idx,c] = kmeans(X,i, 'Start', 'cluster',... 
                              'Replicates', 1, ...
                              'EmptyAction','singleton', ...
                              'Display','final');
    for k = 1:i
        cl_size = size(find(idx == k));
        %metric = sumd(k)
        %disp(['cluster ', num2str(k), ' has ', num2str(cl_size(1)), ' vertices ', num2str(metric)]);
    end
    %allsum = sum(sumd,1);
    %V = [V [i; allsum]];
    %disp(['Stats ', num2str(i), ': ', num2str(sum(sumd,1))]);
    disp('-------------');
  end 
  V = V';
end
