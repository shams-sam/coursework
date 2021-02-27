function x0 = gradientDescent(threshold, x0, alpha, f, debug)
    prev_x = x0 - threshold;
    fx0 = f(x0, 0);
    g0 = f(x0, 1);
    count = 0;
    if debug == 1
        fprintf("gradientDescent %d, [%.4f, %.4f], [%.4f, %.4f], %.4f\n", count, x0, g0, fx0);
    end
    
    while norm(g0) > threshold
        count = count + 1;
        prev_x = x0;
        g0 = f(prev_x, 1);
        x0 = prev_x - alpha*g0;
        fx0 = f(x0, 0);
        if debug == 1
            fprintf("gradientDescent %d, [%.4f, %.4f], [%.4f, %.4f], %.4f\n", count, x0, g0, fx0);
            hold on;
            directedStep(x0, prev_x, 'b', 'ro', 1.0);
        end
    end
end