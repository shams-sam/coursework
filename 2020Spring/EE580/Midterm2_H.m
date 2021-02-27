clear all;
close all;
clc;

xcurr = [1; 2];
vcurr = [0.5; 3.5];

w = 1;
c1 = 2;
c2 = 2;

p = [0.5; 1.5];
g = [5; 6];

r = 0.5*[1; 1];
s = 0.25*[1; 1];

vnext = w*vcurr + (c1*r).*(p-xcurr) + (c2*s).*(g-xcurr);
xnext = xcurr + vnext