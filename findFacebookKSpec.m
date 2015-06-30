function [V] = findFacebookKSpec(G,clusters)
  
  V = []; % Stores the metrics for all the clusterings.

  % Find the matrix decomposition of G 
  [Decomp] = decompose(G,clusters); 
  % Has to be from 2 otherwise kmeans rises an error 
  for i = 2:clusters
  	% Run kmeans for increasing values of k on the decomposition
  	[idx, c, sumd] = k_means(Decomp,i);
  	m = sum(sumd);
    V = [V [i; m]];
    disp(['clusters ', num2str(i), ' metric: ', num2str(m)]);
  end
  V = V';
end