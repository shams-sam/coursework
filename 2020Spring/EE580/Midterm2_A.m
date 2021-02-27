clear all;
close all;
clc;

Q = [ 2 0; 0 1];
b = [1; -1];
c = 7;

% Q = [1 0; 0 2];
% b = [1; -1];
% c = 7;

x0 = [0; 0];
H0 = eye(2);

g0 = Q*x0-b;
d0 = -H0*g0;
alpha0 = -((g0.')*d0)/((d0.')*Q*d0);

x1 = x0+alpha0*d0;

deltax0 = x1-x0;
g1 = Q*x1-b;
deltag0 = g1-g0;

H1 = H0 + ((deltax0*(deltax0.'))/((deltax0.')*deltag0)) - ((H0*deltag0)*((H0*deltag0).'))/((deltag0.')*H0*deltag0);
d1 = -H1*g1;
alpha1 = -(g1.'*d1)/(d1.'*Q*d1);
x2 = x1+alpha1*d1;

alpha1