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
  % Colors used to plot
  colororder = [
	0.00  0.00  1.00
	0.00  0.50  0.00 
	1.00  0.00  0.00 
	0.00  0.75  0.75
	0.75  0.00  0.75
	0.75  0.75  0.00 
	0.25  0.25  0.25
	0.75  0.25  0.25
	0.95  0.95  0.00 
	0.25  0.25  0.75
	0.75  0.75  0.75
	0.00  1.00  0.00 
	0.76  0.57  0.17
	0.54  0.63  0.22
	0.34  0.57  0.92
	1.00  0.10  0.60
	0.88  0.75  0.73
	0.10  0.49  0.47
	0.66  0.34  0.65
	0.99  0.41  0.23
  ];
  set(gca(),'colororder',colororder);
  cla();

  for c = 2:MaxClusters
  	[cIdxs, cCenters, cSumD] = k_means(Decomp,c,'EmptyAction','Singleton', 'Replicates',4);
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
  
  h = figure(3,'visible','off');
  cspy(Graph);
  print(h,'-dpng', '-color', 'original-graph.png');  
end