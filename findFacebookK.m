function [V] = findFacebookK(G,clusters)
  V = 0;
  for i = 1:clusters
    [idx, c, m] = facebook(G,i);
    disp(['clusters ', num2str(i), ' metric: ', num2str(m)]);
  end
end