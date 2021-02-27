clear all;
close all;
clc;

A = [1 0; 0 1; 1 1];
b = [1; 1; 0];

% A = [0 1 1; 0 2 2];
% b = [2; 1];

x_star = pinv(A)*b