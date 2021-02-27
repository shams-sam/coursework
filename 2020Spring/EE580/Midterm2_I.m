clear all;
close all;
clc;

L = 7;
oH = 2;
lH = 4 - 2;

pm = 0.1;
pc = 0.5;
eHk = 10;
Fk = 5;
fHk = 12;

lower_bound = (fHk/Fk)*eHk*(1-(pc*(lH/(L-1))))*(1-pm)^oH