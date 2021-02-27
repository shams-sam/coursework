clear all;
close all;
clc;

a1 = [1 1; 0 0];
a2 = [0 0; 1 1];

pinv(a1*a2)

pinv(a2)*pinv(a1)
