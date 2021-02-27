% Problem 7

interval = 0.1;
x1 = -1.2:interval:1.2;
x2 = -1.2:interval:1.2;

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

for r = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(r,c), X2(r,c)]';
        Z(r,c) = f(x_i, 0);
    end
end

mesh(X1, X2, Z);
box on;
w = waitforbuttonpress;
contour(X1,X2, Z, 10);

function val = f(x, deriv)
    if deriv == 0
        val = (x(2)-x(1))^4 + 12*x(1)*x(2) - x(1) + x(2) - 3;
    elseif deriv == 1
        val = [-4*(x(2)-x(1))^3 + 12*x(2) - 1; 
            4*(x(2)-x(1))^3 + 12*x(1) + 1]; 
    end
end