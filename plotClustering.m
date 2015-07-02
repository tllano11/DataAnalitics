function [C] = plotClustering(Adj, clustering)
  % Returns a classification of the edges in Adj according to their source and 
  % target vertices. If both vertices of an edge are in the same cluster then 
  % the returned matrix contains the cluster index in the representation of that
  % edge.

  numberOfClusters = length(unique(clustering));
  extraCluster = numberOfClusters + 1;
  C = Adj;
  [i,j,v] = find(Adj);  % set i and j to be the indices of non-zeros in A
  pairs = [i,j];
  for i = 1:length(pairs)
  	j = pairs(i,1);
  	k = pairs(i,2);
  	if clustering(j) == clustering(k)
  		C(j,k) = clustering(k);
    else
      C(j,k) = extraCluster;
  	end
  end
end