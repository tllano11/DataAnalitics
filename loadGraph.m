function [G] = loadGraph(filename)
  X  = dlmread(filename);
  dim = max(max(X(:,1)),max(X(:,2))) + 1;
  A = sparse(X(:,1) + 1, X(:,2)  + 1, 1, dim, dim);
  G = full(A);
end
  