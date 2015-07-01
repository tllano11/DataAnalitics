function [C] = plotClustering(Adj, clustering, outputFile)
  C = Adj;
  [i,j,v] = find(Adj);  % set i and j to be the indices of non-zeros in A
  pairs = [i,j];
  for i = 1:length(pairs)
  	j = pairs(i,1);
  	k = pairs(i,2);
  	if clustering(j) == clustering(k)
  		C(j,k) = clustering(k);
  	end
  end

end