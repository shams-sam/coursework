function [a, b] = fibonacciSearch(eps, a, b, f, debug)
    width = norm(b-a);
    fib_N_plus_1 = ceil((1+2*eps)/(eps/width));
    
    fibnums = [1 2];
    N = 1;
    while fibnums(end) < fib_N_plus_1
       fibnums = [fibnums, fibnums(end)+fibnums(end-1)];
       N = N+1;
    end
    
    p = [];
    for i=1:N
       p = [p, 1-fibnums(N-i+1)/fibnums(N-i+2)];
    end
    p(N) = p(N) - 0.05;
    
    s = a;
    t = b;
    fs = f(s, 0);
    ft = f(t, 0);
    
    s = a + p(1)*(b-a);
    t = a + (1-p(1))*(b-a);
    fs = f(s,0);
    ft = f(t,0);
    
    for i=1:N
        
        a_k{i} = s;
        b_k{i} = t;
        fa_k{i} = fs;
        fb_k{i} = ft;
        
        if fs < ft
           b = t;
           t = s;
           if i ~= N
               s = a + p(i+1)*(b-a);
           end
           ft = fs;
           fs = f(s,0);
        else
           a = s;
           s = t;
           if i ~= N
               t = a + (1-p(i+1))*(b-a);
           end
           fs = ft;
           ft = f(t,0);
        end
        
    end
     
    if debug
       fprintf("fibonacciSearch\n");
       i = 1;
       fprintf('%d, %.4f, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f\n', ...
           i, p(i), a_k{i}, b_k{i}, fa_k{i}, fb_k{i});
       for i=2:N
           fprintf("%d, %.4f, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f\n", ...
               i, p(i), a_k{i}, b_k{i}, fa_k{i}, fb_k{i});
           pt = (a_k{i} + b_k{i})/2;
           prev_pt = (a_k{i-1} + b_k{i-1})/2;
           directedStep(pt, prev_pt, 'b', 'ro', 0.3);
       end
    end
end