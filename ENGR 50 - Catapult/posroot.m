%{
    Picks the positive root of the solution of a quadratic function
%}
function root = posroot(r1, r2)    
    if(r1 > 0)
        root = r1;
        return;
    elseif(r2 > 0)
        root = r2;
        return;
    else
        error('Neither of the roots are positive!');
    end
end