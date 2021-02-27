function y = clamp(z, minval, maxval)
    d = length(z);
    for i=1:d
        if z(i) > maxval
            z(i)=maxval;
        elseif z(i) < minval
            z(i)=minval;
        end
    end
    y = z;
end