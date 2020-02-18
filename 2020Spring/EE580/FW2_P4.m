Q = [2 1; 1 2];

x0 = [0.8, -0.25]';
[a, b] = bracketRegion(x0, Q, 0);

x1 = linspace(a(1), b(1), 100);
x2 = linspace(a(2), b(2), 100);

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

for r = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(r,c), X2(r,c)]';
        Z(r,c) = quadratic(x_i, Q, [0, 0]', 0);
    end
end

contour(X1, X2, Z, 10);

[a, b] = goldenSection(0.05, a, b, @quadratic, Q, [0 0]', 0, 1);

minimizer = (a+b)/2;