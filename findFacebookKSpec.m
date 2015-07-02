% G -> Graph's Adjacency matrix
% clusters -> Number of clusters
function [V,D,C,Bk] = findFacebookKSpec(G,clusters, option)

  if nargin < 2
    error('At least two input arguments required.');
  end

  V = []; % Stores the metrics for all the clusterings.
  C{1} = []; %Stores an adjacency matrix, returned by plotClustering, for each clustering
  Bk = [0,Inf]; %Stores the best k value based on the metric

  % Find the matrix decomposition of G
  [Decomp] = decompose(G,clusters);
  D = Decomp;
  % Has to be from 2 otherwise kmeans rises an error
  for i = 2:clusters
    % Run kmeans for increasing values of k on the decomposition
    [idx, c, sumd] = k_means(Decomp,i,'EmptyAction','Singleton');
    m = sum(sumd);
    modul = modularity (idx, G);
    % Checks which is the best clustering
    if m < Bk(1,2)
      Bk(1,1) = i;
      Bk(1,2) = m;
    end
    V = [V [i; m; modul]];
    C{i} = plotClustering(G, idx);
    disp(['clusters ', num2str(i), ' metric: ', num2str(m)]);
  end
  V = V';

  if nargin == 3
    switch option
      case 'ShowMetricsChart'
	plot(V(:,1), V(:,2));
      case 'ShowModularityChart'
	plot(V(:,1), V(:,3));
      case 'ShowAllCharts'
	plotyy(V(:,1), V(:,2),V(:,1), V(:,3));
      case 'SaveAllCharts'
	  f = figure (1,'visible','off');
	  plot(V(:,1), V(:,2));
	  print(f, '-dpng', '-color','MetricsChart.png');
	  f2 = figure (2,'visible','off');
	  plot(V(:,1), V(:,3));
	  print(f2, '-dpng', '-color','ModularityChart.png');
     end
   end
end
