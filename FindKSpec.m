function [X,idx] = FindKSpec(n, csize, d, d2, iterations)
  X = Graph(n,csize,d,d2);
  V = [];
  for i = 1:iterations
  [idx,L,U] = SpectralClustering(X,i,1);
    for k = 1:i
        cl_size = size(find(idx == k));
        disp(['cluster ', num2str(k), ' has ', num2str(cl_size(1)), ' vertices']);
    end
    disp('-------------');
  end 
end
