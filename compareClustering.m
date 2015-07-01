function [M] = compareClustering(idx1, idx2)
	l1 = length(unique(idx1));
	l2 = length(unique(idx2));
	M = zeros(l1, l2);
	for i = 1:l1
		for j = 1:l2
			c1 = find(idx1 == i);
			c2 = find(idx2 == j);
			inter = intersect(c1, c2);
			M(i,j) = length(inter) / length(c2);
		end
	end
end