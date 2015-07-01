function [M] = modularity(clustering,G)
  clusters = length(unique(clustering));
  e = zeros(clusters,1);
  [i,j,v] = find(G);  % set i and j to be the indices of non-zeros in G
  E = [i,j]; % Edges in the graph
  Ecard = length(E);   % Number of edges
  for i=1:Ecard
  	j = E(i,1);
  	k = E(i,2);
  	if clustering(j) == clustering(k)
      e(clustering(j)) = e(clustering(j)) + 1;
    end
  end
  e = e ./ Ecard;

  a = zeros(clusters,1);
  for i=1:Ecard
  	j = E(i,1);
  	k = E(i,2);
  	a(clustering(k)) = a(clustering(k)) + 1;  % Does this work on undirected graph??
  end
  a = a ./ Ecard;

  M = sum(e - a.^2);
end