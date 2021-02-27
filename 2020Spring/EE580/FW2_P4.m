clear all;
close all;
clc;

Q = [2 1; 1 2];
f = @(v) 0.5*(v.')*Q*v;
x0 = [0.8; -0.25];
d = -Q*x0;
eps = 0.05;

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

before_optim = f((a+b)/2);
[a, b] = goldenSection(eps, a, b, f, 1);
after_optim = f((a+b)/2);

minimizer = (a+b)/2;