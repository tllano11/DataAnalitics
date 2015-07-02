function [Metrics] = benchmark(Graph, Decomp, MaxClusters)
  % Graph: input graph
  % Decomp: graph decomposition
  % MaxClusters: maximum number of clusters to try.

  assert(MaxClusters > 1, 'At least two clusters');
  assert(size(Decomp,2) >= MaxClusters, 'Not enough columns in decomposition');

  % Column 1: number of clusters
  % Column 2: Distance to centroid
  % Column 3: Modularity
  Metrics = []; 

  graphics_toolkit gnuplot
  for c = 2:MaxClusters
  	[cIdxs, cCenters, cSumD] = k_means(Decomp,c,'EmptyAction','Singleton'); %,'Replicates',4);
  	distanceToCentroidMetric = sum(cSumD);
  	modularityMetric = modularity(cIdxs, Graph);
  	Metrics = [Metrics [c; distanceToCentroidMetric; modularityMetric]];

  	clusterView = plotClustering(Graph, cIdxs);
	f = figure(1,'visible','off');
  	cspy(clusterView);
  	print(f,'-dpng', '-color', strcat('clustering-',num2str(c),'.png'));
  end

  Metrics = Metrics';
  Clustering = Metrics(:,1);
  Distance = Metrics(:,2);
  Modularity =  Metrics(:,3);
  g = figure(2,'visible','off');
  [p, hd, hm] = plotyy(Clustering, Distance, Clustering, Modularity);
  xlabel('Number of clusters');
  ylabel(p(1), 'Distance to centroids');
  ylabel(p(2), 'Modularity');
  print(g,'-dpng', '-color', 'clustering-stats.png');

  % Requires miscellaneous package in octave
  textable(Metrics, 'file', 'clustering-stats.tex');
end