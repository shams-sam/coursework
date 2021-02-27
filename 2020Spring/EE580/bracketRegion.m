function [a, b] = bracketRegion(x0, f, d, eps, debug)
    n=1;
    x = {x0};
    fx = {f(x0, 0)};

    n = 2;
    x{n} = x{n-1} + eps*d;
    fx{n} = f(x{n}, 0);
    
    while fx{n} < fx{n-1}
        n = n+1;
        eps = 2*eps;
        x{n} = x{n-1} + eps*d;
        fx{n} = f(x{n}, 0);
    end
    a = x{n-2};
    b = x{n};
    
    if debug
        fprintf('bracketRegion\n');
        fprintf('%d, [%.4f, %.4f], %.4f\n', 0, x{1}, fx{1}); 
        for i = 2:n
           fprintf('x%d, [%.4f, %.4f], %.4f\n', i-1, x{i}, fx{i});
           directedStep(x{i}, x{i-1}, 'b', 'ro', 0.3);
        end
        fprintf('bracket: [x%d, x%d]\n', n-3, n-1);
        fprintf('interval: %.4f\n', norm(b-a));
    end
end