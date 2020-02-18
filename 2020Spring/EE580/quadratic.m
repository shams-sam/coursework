function r = quadratic(x, Q, b, c)
    r = 1/2*x'*Q*x - x'*b + c;
end