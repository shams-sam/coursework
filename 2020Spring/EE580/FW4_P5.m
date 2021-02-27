clear all;
close all;
clc;

c = [6; 4; 7; 5];
A = [1 2 1 2; 6 5 3 2; 3 4 9 12];
b = [20; 100; 75];

[X, val] = linprog(-c', A, b, [], [], [0 0 0 0], [Inf Inf Inf Inf]);
