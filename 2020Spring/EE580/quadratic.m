function f = quadratic(d)
    if d == 0
        
    elseif d == 1
        f = @(v) Q*v;
    elseif d == 2
        f = Q;
    end
end