function y = HelloWorld(maxLoop)
    x = (1:10)';
    y = log(x);
    for k = 1:maxLoop
        y(:,k)=k*log(x);
    end
    %Plot the graph
    plot(x,y);