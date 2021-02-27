function y = d2b(num, min, max, res)
    scaled = (num-min)/(max-min)*(2^res-1);
    
    y = fix(rem(scaled*pow2(-(res-1):0),2));
end
