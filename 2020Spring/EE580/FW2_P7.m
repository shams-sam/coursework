% Problem 7

interval = 0.1;
x1 = -1.2:interval:1.2;
x2 = -1.2:interval:1.2;

[X1, X2] = meshgrid(x1, x2);
Z = (X1-X2)^4 - 12*X1*X2 - X1 + X2 - 3;

mesh(X1, X2, Z);
w = waitforbuttonpress;
contour(X1,X2, Z, 10);
