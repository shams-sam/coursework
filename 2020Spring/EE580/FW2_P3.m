interval = 0.1;
x1 = -2:interval:2;
x2 = -2:interval:2;

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

Q = [2 1; 1 2];

for r = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(r,c), X2(r,c)]';
        Z(r,c) = quadratic(x_i, Q, [0, 0]', 0);
    end
end

contour(X1, X2, Z, 10);
hold on;
plot(0.8, -0.25, 's');

x0 = [0.8, -0.25]';
[a, b] = bracketRegion(x0, Q, 1);
