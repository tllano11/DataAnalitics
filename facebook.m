function [idx,c,M] = facebook(G, clusters) 
  [idx,c] = kmeans(G,clusters,'EmptyAction','singleton');
  M = 0;
  for j = 1:clusters
    cluster = find(idx==j);
    rows = G(cluster);
    center = c(j,:);
    for i = 1:length(cluster)
      point = rows(i,:);
      distance = norm(point -  center);
      M = M + distance;   
    end
  end
end
