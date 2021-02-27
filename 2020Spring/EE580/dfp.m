function x0 = dfp(x0, f, g, X1, X2, Z, debug)
    H_k = {eye(2)};
    g0 = g(x0);
    g_k = {g0};
    x_k = {x0};
    for k = 1:2
        if g_k{k} ~= 0
            d_k{k} = -H_k{k}*g_k{k};
            [alpha_a, alpha_b] = bracketRegion(0.05, @phi, -phi(0.05, 1), 0.0001, 0);
            [alpha_a, alpha_b] = fibonacciSearch(0.0001, alpha_a, alpha_b, @phi, 0);
            alpha_k{k} = (alpha_a + alpha_b)/2;
            x_k{k+1} = x_k{k} + alpha_k{k}*d_k{k};
            directedStep(x_k{k+1}, x_k{k}, 'b', 'ro', 1.0);
            fxk = f(x_k{k+1});
            contour(X1, X2, Z, [fxk fxk]);
            g_k{k+1} = g(x_k{k+1});
            if g_k{k+1} ~= 0
                del_x{k} = x_k{k+1}-x_k{k};
                del_g{k} = g_k{k+1}-g_k{k};
                H_k{k+1} = H_k{k} + (del_x{k}*(del_x{k}.'))/((del_g{k}.')*del_x{k}) - ((H_k{k}*del_g{k})*((H_k{k}*del_g{k}).'))/((del_g{k}.')*H_k{k}*del_g{k});
                k = k+1;
            end
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