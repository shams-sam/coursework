function y = griewank(x)
    d = length(x);
    sum = 0;
    prod = 1;
    
    for i=1:d
       xi = x(i);
       sum = sum + xi^2/4000;
       prod = prod * cos(xi/sqrt(i));
    end
    
    y = sum - prod + 1;
end