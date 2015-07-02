% G -> Graph's Adjacency matrix
% clusters -> Number of clusters
function [V,D,C,Bk] = findFacebookKSpec(G,clusters)

  V = []; % Stores the metrics for all the clusterings.
  C{1} = []; %Stores an adjacency matrix, returned by plotClustering, for each clustering
  Bk = [0,Inf]; %Stores the best k value based on the metric

  % Find the matrix decomposition of G
  [Decomp] = decompose(G,clusters);
  D = Decomp;
  % Has to be from 2 otherwise kmeans rises an error
  for i = 2:clusters
    % Run kmeans for increasing values of k on the decomposition
    [idx, c, sumd] = k_means(Decomp,i);
    m = sum(sumd);
    modul = modularity (idx, G);
    if m < Bk(1,2)
      Bk(1,1) = i;
      Bk(1,2) = m;
    end
    V = [V [i; m; modul]];
    C{i} = plotClustering(G, idx);
    disp(['clusters ', num2str(i), ' metric: ', num2str(m)]);
  end
  V = V';
  end
