function x0 = newtonsMethod(threshold, x0, f, X1, X2, Z, debug)
    prev_x = x0 - threshold;
    count = 0;
    fx0 = f(x0, 0);
    g0 = f(x0, 1);
    if debug == 1
       fprintf('newtonsMethod %d, [%.4f, %.4f], [%.4f, %.4f], %.4f\n', count, x0, g0, fx0);
    end
    while norm(x0 - prev_x) > threshold
        prev_x = x0;
        g0 = f(prev_x, 1);
        x0 = prev_x - inv(f(prev_x, 2))*g0;
        fx0 = f(x0, 0);
        
        count = count + 1;
        if debug == 1
            fprintf('newtonsMethod %d, [%.4f, %.4f], [%.4f, %.4f], %.4f\n', count, x0, g0, fx0);
            hold on;
            directedStep(x0, prev_x, 'b', 'ro', 0.5);
            hold on;
            contour(X1, X2, Z, [fx0 fx0]);
        end
       
        if fx0 == 0
            break
        end
    end
end