clear all;
close all;
clc; 

A0 = [0 1; 1 1; 0 1];
A1 = [1 0];

A = [A0; A1];

A_inv = pinv(A)