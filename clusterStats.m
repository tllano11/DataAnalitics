function [stats]  =  clusterStats(clustering)
  clustersNum = size(unique(clustering));
  verticesNum = rows(clustering);
  for i = 1:clustersNum
    cSize = size(find(clustering == i))(1,1);
    perc = cSize / verticesNum * 100;
    disp(['cluster ', num2str(i), ' has ', num2str(cSize(:,1)), ' ', num2str(perc)  ]);
  end
end