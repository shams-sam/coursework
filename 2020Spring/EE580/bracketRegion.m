function [a, b] = bracketRegion(x0, Q, debug)
    prev_x = x0;
    prev_Z = 1/2*x0'*Q*x0;
    if debug == 1
        fprintf("%d, [%.4f, %.4f], %.4f\n", 0, prev_x, prev_Z);
    end

    count = 0;
    while count < 1000
        count = count+1;
        xi = prev_x - 2^(count-1)*0.1*Q*prev_x;
        Zi = 1/2*xi'*Q*xi;
        
        if debug == 1
            fprintf("%d, [%.4f, %.4f], %.4f\n", count, xi, Zi);
            directedStep(xi, prev_x, count, count-1);
        end
           
        if Zi > prev_Z
            b = xi;
            break
        end
        prev_x = xi;
        prev_Z = Zi;
    end
    a = prev_x;
end