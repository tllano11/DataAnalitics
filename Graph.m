function result = Graph(n, csize, d, d2)
    % d: Connections outside the community
    % d2: Connections within the communities 

    function result = SubGraph(c, p)
        A = randsrc(c,c,[0,1;1-p,p]);
        B = tril(A);
        D = B  + B';
        D((D > 1)) = 1;
        result = D;
    end

    p = d2/csize;
    q = d/n;
    G = SubGraph (n,q);
      
    for i = 0:(n/csize)-1
      C = SubGraph (csize, p);
      start = (i * csize) + 1 ;
      e = start + csize -1 ;
      G (start:e, start:e) = C;
    end     
      
    result = G;
end
