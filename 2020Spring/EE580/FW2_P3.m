clear all;
close all;
clc;

Q = [2 1; 1 2];
f = @(v) 0.5*(v.')*Q*v;
x0 = [0.8; -0.25];
d = -Q*x0;
eps = 0.1;

interval = 0.1;
x1 = -1:interval:1;
x2 = -1:interval:1;

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
hold on;
plot(0.8, -0.25, 'ro');

before_optim = f(x0);
[a, b] = bracketRegion(x0, f, d, eps, 1);
after_optim = f((a+b)/2);
