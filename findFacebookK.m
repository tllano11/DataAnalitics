function [V] = findFacebookK(G,clusters)
  V = [];;
  for i = 1:clusters
    [idx, c, m] = facebook(G,i);
    V = [V [i; m]];
    disp(['clusters ', num2str(i), ' metric: ', num2str(m)]);
  end
  V = V';
end