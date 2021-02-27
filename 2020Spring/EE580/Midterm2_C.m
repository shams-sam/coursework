clear all;
close all;
clc;

A = [1 0; 0 1; 0 -1];
b = [0-(-2); 2-0; 1-0];

% A = [0 1; -1 0; 0 -1];
% b = [1; -2; -4];

x = inv(A.'*A)*A.'*b