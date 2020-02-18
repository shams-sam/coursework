load karate.mat;

% https://github.com/aeolianine/octave-networks-toolbox/blob/master/laplacianMatrix.m
function L=laplacianMatrix(A)
  L=diag(sum(A))-A;
endfunction;

L = laplacianMatrix(A);

[V D] = eig(L);

