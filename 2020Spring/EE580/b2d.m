function y = b2d(num, min, max, res)
    scaled = num*pow2(res-1:-1:-0).';
    y = min + (scaled*(max-min)/(2^res-1));
end