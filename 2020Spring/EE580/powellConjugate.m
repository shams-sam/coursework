function x0 = powellConjugate(x0, f, g, X1, X2, Z, debug)
    k = 1;
    x = {x0};
    g0 = g(x0);
    g_k = {g(x0)};
    d_k = {-g_k{k}};
    x_k = {x0};
    while k <= 2
        d = d_k{k};
        [alpha_a, alpha_b] = bracketRegion(0.05, @phi, -phi(0.05, 1), 0.0001, 0);
        [alpha_a, alpha_b] = fibonacciSearch(0.0001, alpha_a, alpha_b, @phi, 0);
        alpha_k{k} = (alpha_a + alpha_b)/2;
        
        k = k+1;
        x{k} = x{k-1} + alpha_k{k-1} * d;
        directedStep(x{k}, x{k-1}, 'b', 'ro', 1.0);
        fxk = f(x{k});
        contour(X1, X2, Z, [fxk fxk]);
        g_k{k} = g(x{k});
        if g_k{k} == 0
            break
        end
        b{k-1} = max(0, (g_k{k}.' * (g_k{k}-g_k{k-1}))/(g_k{k-1}.'*g_k{k-1}));
        d_k{k} = -g_k{k}+b{k-1}*d_k{k-1};
    end
    
    x0 = x{k};
    
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