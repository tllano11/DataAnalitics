function [idx,c,M] = facebook(G, clusters) 
  [idx,c] = k_means(G,clusters,'EmptyAction','singleton');
  M = 0;
  for j = 1:clusters
    cluster = find(idx==j);
    rows = G(cluster);
    center = c(j,:);
    for i = 1:length(cluster)
      point = rows(i,:);
      distance = sum((point - center).*(point - center));
      %v = point - center;
      %distance = (v * v')^2; %norm(point -  center);
      M = M + distance;   
    end
  end
  disp(['Metric ', num2str(M)]);
  clusterStats(idx);
end
