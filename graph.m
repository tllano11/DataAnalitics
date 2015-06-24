## Copyright (C) 2011 Soren Hauberg
## Copyright (C) 2012 Daniel Ward
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see .
## -*- texinfo -*-
## @deftypefn {Function File} {[@var{idx}, @var{centers}] =} kmeans (@var{data}, @var{k}, @var{param1}, @var{value1}, @dots{})
## K-means clustering.
##
## @seealso{linkage}
## @end deftypefn

function [classes, centers, sumd, D] = k_means (data, k, varargin)
  [reg, prop] = parseparams (varargin);
  ## defaults for options
  emptyaction = "error";
  start       = "sample";
  #used for getting the number of samples
  nRows = rows (data);
  ## used to hold the distances from each sample to each class
  D = zeros (nRows, k);
  #used for convergence of the centroids
  err = 1;
  #initial sum of distances
  sumd = Inf;
  ## Input checking, validate the matrix and k
  if (!isnumeric (data) || !ismatrix (data) || !isreal (data))
    error ("kmeans: first input argument must be a DxN real data matrix");
  elseif (!isscalar (k))
    error ("kmeans: second input argument must be a scalar");
  endif
  if (length (varargin) > 0)
    ## check for the ‘emptyaction’ property
    found = find (strcmpi (prop, "emptyaction") == 1);
    switch (lower (prop{found+1}))
      case "singleton"
        emptyaction = "singleton";
      otherwise
        error ("kmeans: unsupported empty cluster action parameter");
    endswitch
  endif
  ## check for the ‘start’ property
  switch (lower (start))
    case "sample"
      idx = randperm (nRows) (1:k);
      centers = data (idx, :);
    otherwise
      error ("kmeans: unsupported initial clustering parameter");
  endswitch
  ## Run the algorithm
  while err > .001
    ## Compute distances
    for i = 1:k
      D (:, i) = sumsq (data - repmat (centers(i, :), nRows, 1), 2);
    endfor
    ## Classify
    [tmp, classes] = min (D, [], 2);
    ## Calculate new centroids
    for i = 1:k
      ## Get binary vector indicating membership in cluster i
      membership = (classes == i);
      ## Check for empty clusters
      if (sum (membership) == 0)
        switch emptyaction
          ## if ‘singleton’, then find the point that is the
          ## farthest and add it to the empty cluster
          case 'singleton'
           idx=maxCostSampleIndex (data, centers(i,:));
           classes(idx) = i;
           membership(idx)=1;
         ## if ‘error’ then throw the error
          otherwise
            error ("kmeans: empty cluster created");
        endswitch
     endif ## end check for empty clusters
      ## update the centroids
      members = data(membership, :);
      centers(i, :) = sum(members,1)/size(members,1);
    endfor
    ## calculate the difference in the sum of distances
    err  = sumd - objCost (data, classes, centers);
    ## update the current sum of distances
    sumd = objCost (data, classes, centers);
  endwhile
endfunction
## calculate the sum of distances
function obj = objCost (data, classes, centers)
  obj = 0;
    for i=1:rows (data)
      obj = obj + sumsq (data(i,:) - centers(classes(i),:));
    endfor
endfunction
function idx = maxCostSampleIndex (data, centers)
  cost = 0;
  for idx = 1:rows (data)
    if cost < sumsq (data(idx,:) - centers)
      cost = sumsq (data(idx,:) - centers);
    endif
  endfor
endfunction



function result = SubGraph(c, p)
	 A = discrete_rnd ([0,1], [1-p,p], [c,c]);
	 B = tril(A);
	 D = B  + B';
   D((D > 1)) = 1;
	 result = D;
endfunction

% d: Connections outside the community
% d2: Connections within the communities 
function result = Graph(n, csize, d, d2)
      p = d2/csize;
      q = d/n;
      G = SubGraph (n,q);
      
      for i = 0:(n/csize)-1
        C = SubGraph (csize, p);
        start = (i * csize) + 1 ;
        e = start + csize -1 ;
        G (start:e, start:e) = C;
      endfor     
      
      result = G;
endfunction

function result = Metric(X, K)
  [idx,centers] = kmeans(X,K);
  M = 0;
  for j= 1:K
    # Compute th rows of X that are in cluster j
    cl = find(idx == j);
    disp(['cluster ', num2str(j), ' has ', num2str(length(cl)), ' vertices']);
    rowsOfCluster = X(cl,:);
    
    # Center of cluster j
    cj = centers(j,:);
    
    for i=1:length(cl)
      #disp(['iteration ', num2str(i)]);
      # Compute the distance from the point to the center
      point = rowsOfCluster(i,:);
      distance = norm(point - cj);
      M = M + distance;
    endfor
  endfor
  result = M;
endfunction

function result = FindK(n, csize, d, d2, iterations)
  X = Graph(n,csize,d,d2);
  #spy(X);
  V = [];
  for i = 1:iterations
    M = Metric(X,i);
    V = [V [i;M]];
  endfor 
  V = V'; 
  plot(V(:,1), V(:,2))
  result = V;
endfunction
