function [V] = findFacebookK(G,clusters)
  V = [];
  % Has to be from 2 otherwise kmeans rises an error
  for i = 2:clusters
    [idx, c, m] = facebook(G,i);
    V = [V [i; m]];
    disp(['clusters ', num2str(i), ' metric: ', num2str(m)]);
  end
  V = V';
end