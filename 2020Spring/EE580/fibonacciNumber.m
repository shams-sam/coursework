function r = fibonacciNumber(n)
    root_five = 5^(1/2);
    r = (1/root_five) * (((1+root_five)/2)^n - ((1-root_five)/2)^n);
end