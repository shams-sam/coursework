clear all;
close all;
clc;

A = [0 0; 1 2; 1 2];
b = [2; 1; 2];

x = pinv(A)*b