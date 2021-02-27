clear all;
close all;
clc;

Aplusbc_inv = [1 0 -1; 0 2 1; 0 -1 0];
A_invb = [0; -1; 1];
cA_inv = [0 1 1];
cA_invb = 0;

A_inv = Aplusbc_inv + (A_invb*inv(eye(1)+cA_invb)*cA_inv)