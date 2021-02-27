clear all;
close all;
clc; 

A0 = [0 1; 1 1; 0 1];
b0 = [0; 1; 0];

A1 = [1 0]; 
b1 = 2;


P0 = inv((A0.')*A0);
x0 = P0*A0.'*b0;

P1 = P0 - (P0*(A1.')*A1*P0)/(1+(A1*P0*A1.'))