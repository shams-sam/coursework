clear all;
close all;
clc;
 
% c = [3; 1; 1];
% A = [1 0 1; 0 1 -1];
% b = [4; 2];

% c = [-1; -3];
% A = [-2 1; -1 2];
% b = [2; 7];

c = [1; 1; 1];
A = [1 1 -1; 0 -1 0];
b = [2; 1];

[X, val] = linprog(c', [], [], A, b, zeros(3, 1));
X