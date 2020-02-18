function [a, b] = goldenSection(threshold, a, b, f, Q, bb, c, debug)
    p = (3-5^(1/2))/2;

    s = a + p*(b-a);
    t = a + (1-p)*(b-a);
    fs = f(s, Q, bb, c);
    ft = f(t, Q, bb, c);
    
    prev_pt = (a+b)/2;

    if debug
        fprintf('%d, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f\n', 0, a, b, fs, ft);
    end
    count = 0;
    while norm(b-a) > threshold
       if fs < ft
          b = t;
          t = s;
          s = a + p*(b-a);
          ft = fs;
          fs = f(s, Q, bb, c);
       else
          a = s;
          s = t;
          t = a + (1-p)*(b-a);
          fs = ft;
          ft = f(t, Q, bb, c);
       end
       count = count + 1;
       if debug
           fprintf('%d, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f\n', count, a, b, fs, ft);
           pt = (a+b)/2;
           hold on;
           directedStep(pt, prev_pt, count, count-1);
           prev_pt = pt;
       end
    end
end