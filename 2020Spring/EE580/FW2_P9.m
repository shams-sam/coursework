x1 = linspace(-1.2, 1.2, 100);
x2 = linspace(-1.2, 1.2, 100);

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

for r = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(r,c), X2(r,c)]';
        Z(r,c) = f(x_i, 0);
    end
end

figure;
contour(X1, X2, Z, 15, '--');

x0 = [0.55; 0.7];
before_optim = f(x0, 0);
x = newtonsMethod(0.05, x0, @f, X1, X2, Z, 1);
[a, b] = bracketRegion(x0, @f, 0.1, 0);
[a, b] = goldenSection(0.05, a, b, @f, 0);
a,b, (a+b)/2
x = newtonsMethod(0.05, a, @f, X1, X2, Z, 1);
after_optim = f(x, 0);

x0 = [-0.9; -0.5];
before_optim = f(x0, 0);
x = newtonsMethod(0.05, x0, @f, X1, X2, Z, 1);
after_optim = f(x, 0);


function val = f(x, deriv)
    if deriv == 0
        val = (x(2)-x(1))^4 + 12*x(1)*x(2) - x(1) + x(2) - 3;
    elseif deriv == 1
        val = [4*(x(1)-x(2))^3 + 12*x(2) - 1; -4*(x(1)-x(2))^3 + 12*x(1) + 1]; 
    elseif deriv == 2
        val = [12*(x(1)-x(2))^2 -12*(x(1)-x(2))^2 + 12; -12*(x(1)-x(2))^2 + 12 12*(x(1)-x(1))^2];
    end
end