function [idx,M] = facebookSpec(G, clusters) 
  [idx,L, U,sumD] = SpectralClustering(G,clusters,1);
  M = sum(sumD);
  disp(['Metric ', num2str(M)]);
  clusterStats(idx);
end
