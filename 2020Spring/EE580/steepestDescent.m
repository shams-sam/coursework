function x0 = steepestDescent(eps, x0, f, g, X1, X2, Z, debug)
    prev_x = x0 - eps;
    fx0 = f(x0);
    g0 = g(x0);
    count = 0;
    
    if debug == 1
        fprintf("steepestDescent %d, [%.4f, %.4f], [%.4f, %.4f], %.4f\n", count, x0, g0, fx0);
    end
    
    while norm(x0-prev_x) > eps
        count = count + 1;
        prev_x = x0;
        dot_prod = g0'*f(prev_x);
        g0 = g(prev_x);
        [alpha_a, alpha_b] = bracketRegion(0.05, @phi, -phi(0.05, 1), 0.0001, 0);
        [alpha_a, alpha_b] = fibonacciSearch(0.0001, alpha_a, alpha_b, @phi, 0);
        alpha = (alpha_a + alpha_b)/2;
        x0 = prev_x - alpha*g0;
        fx0 = f(x0);
        if debug == 1
            fprintf("steepestDescent %d, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f\n", count, x0, g0, alpha, fx0);
            hold on;
            directedStep(x0, prev_x, 'b', 'ro', 1.0);
            contour(X1, X2, Z, [fx0 fx0]);
        end
    end
    
    
    function val = phi(alpha, deriv)
        if deriv == 0
            val = f(x0 - alpha*g0);
        elseif deriv == 1
            syms alpha_i;
            val = diff(f(x0 - alpha_i*g0), alpha_i);
            alpha_i = alpha;
            val = vpa(subs(val));
        end
    end
end