close all;
clear all;
clc;

Q = [2 1; 1 2];
x0 = [0.8, -0.25]';
f = @(x) 0.5*(x.')*Q*x;
d = -Q*x0;
[a, b] = bracketRegion(x0, f, d, 0.1, 0);

x1 = linspace(a(1), b(1), 100);
x2 = linspace(a(2), b(2), 100);

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

for r = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(r,c), X2(r,c)]';
        Z(r,c) = f(x_i);
    end
end

figure;
contour(X1, X2, Z, 10, '--');

eps = 0.05;
before_optim = f((a+b)/2);
[a, b] = fibonacciSearch(eps, a, b, f, 1);
after_optim = f((a+b)/2);

minimizer = (a+b)/2;