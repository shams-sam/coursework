function [a, b] = goldenSection(threshold, a, b, f, debug)
    p = (3-5^(1/2))/2;
    width = norm(b-a);
    N = ceil((log(threshold/width)/log(1-p)));

    s = a + p*(b-a);
    t = a + (1-p)*(b-a);
    fs = f(s);
    ft = f(t);
    
    prev_pt = (a+b)/2;

    for i = 1:N
        a_k{i} = s;
        b_k{i} = t;
        fa_k{i} = fs;
        fb_k{i} = ft;
        if fs < ft
            b = t;
            t = s;
            s = a + p*(b-a);
            ft = fs;
            fs = f(s);
        else
            a = s;
            s = t;
            t = a + (1-p)*(b-a);
            fs = ft;
            ft = f(t);
        end
        interval{i} = [a b];
        len{i} = norm(b-a);
    end
    if debug
        fprintf('goldenSection\n\n');
        i = 1;
        fprintf(...
            '%d, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f, %.4f\n', ...
            i, a_k{i}, b_k{i}, fa_k{i}, fb_k{i}, len{i});
        for i = 2:N
            fprintf(...
                '%d, [%.4f, %.4f], [%.4f, %.4f], %.4f, %.4f, %.4f\n', ...
                i, a_k{i}, b_k{i}, fa_k{i}, fb_k{i}, len{i});
                pt = (a_k{i}+b_k{i})/2;
                prev_pt = (a_k{i-1}+b_k{i-1})/2;
                hold on;
                directedStep(pt, prev_pt, 'b', 'ro', 0.3);
        end
        fprintf('\n\n');
   end
end