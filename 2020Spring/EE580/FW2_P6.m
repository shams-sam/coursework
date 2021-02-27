Q = [2 1; 1 2];

x0 = [0.8, -0.25]';

x1 = linspace(-1, 1, 100);
x2 = linspace(-1, 1, 100);

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

for r = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(r,c), X2(r,c)]';
        Z(r,c) = quadratic(x_i, 0);
    end
end

figure;
contour(X1, X2, Z, 10, '--');

threshold = 0.05;
before_optim = quadratic(x0, 0);
x = newtonsMethod(threshold, x0, @quadratic, X1, X2, Z, 1);
after_optim = quadratic(x, 0);

minimizer = x0;