close all;
clear all;
clc;

fx = @(x1, x2) 20 + (x1/10)^2 + (x2/10)^2 - 10*(cos(2*pi*x1/10) + cos(2*pi*x2/10));
gx = @(x1, x2) [x1/50 + 2*pi*sin((pi*x1)/5); x2/50 + 2*pi*sin((pi*x2)/5)];
f = @(x) fx(x(1), x(2));
g = @(x) gx(x(1), x(2));

x1 = linspace(6, 14, 100);
x2 = linspace(6, 14, 100);

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

x0 = [7.5; 9.0];
hold on;
plot(x0(1), x0(2), 'ro');
eps = 0.05;
x = dfp(x0, f, g, X1, X2, Z, 1);

x1 = linspace(-6, -14, 100);
x2 = linspace(-6, -14, 100);

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

x0 = [-7.0; -7.5];
hold on;
plot(x0(1), x0(2), 'ro');
eps = 0.05;
x = dfp(x0, f, g, X1, X2, Z, 1);