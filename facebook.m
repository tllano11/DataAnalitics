function [idx,c,M] = facebook(G, clusters) 
  [idx,c,sumD] = k_means(G,clusters,'EmptyAction','singleton');
  M = sum(sumD);
  disp(['Metric ', num2str(M)]);
  clusterStats(idx);
end
