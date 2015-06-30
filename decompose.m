function [Decomp] = decompose(W, k)
%   'W' - Adjacency matrix, needs to be square
%   'k' - Number of eigen vectors in the decomposition

% calculate degree matrix
degs = sum(W, 2);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);

% compute unnormalized Laplacian
L = D - W;

% compute the eigenvectors corresponding to the k smallest
% eigenvalues
diff   = eps;
[Decomp, ~] = eigs(L, k, diff);
end