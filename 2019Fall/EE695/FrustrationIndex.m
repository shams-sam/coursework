% Names and connections in syrian conflict
% Data from http://www.slate.com/blogs/the_slatest/2015/10/06/syrian_conflict_relationships_explained.html

names = {
  'Syrian Government';
  'Syrian Rebels';
  'ISIS';
  'Jabhat al-Nusra';
  'Kurds';
  'U.S. and Allies';
  'Iraq';
  'Iran and Hezbollar';
  'Russia';
  'Saudi Arabia, Gulf States';
  'Turkey';
};

positive_conns = [
  1 7;
  1 8;
  1 9;
  2 6;
  2 10;
  2 11;
  5 6;
  5 8;
  5 9;
  6 7;
  6 10;
  6 11;
  7 8;
  7 9;
  8 9;
  10 11;
];

negative_conns = [
  1 2;
  1 3;
  1 4;
  1 6;
  1 10;
  1 11;
  2 3;
  2 7;
  2 8;
  2 9;
  3 4;
  3 5;
  3 6;
  3 7;
  3 8;
  3 9;
  3 10;
  3 11;
  4 5;
  4 6;
  4 7;
  4 8;
  4 9;
  5 7;
  5 11;
  8 10;
  9 10;
  9 11;
];

A = zeros(11, 11);

for i = 1:length(positive_conns)
  A(positive_conns(i,1),positive_conns(i,2)) = 1;
end

for i = 1:length(negative_conns)
  A(negative_conns(i,1),negative_conns(i,2)) = -1;
end

global A frustIndex;

A = A + A';

numNodes = size(A)(1);

s = ones(1, numNodes);
frustIndex = numNodes*numNodes;

function retval = countNegatives(A)
  retval = length(nonzeros(A(A<0)));
endfunction

function minFrustIndex = switching(n, s, i)
  if i>n
    iterFrust = countNegatives(s.*A.*s');
    if iterFrust < frustIndex
      frustIndex, iterFrust
      frustIndex = iterFrust;
      s, frustIndex
    endif;
    break;
  endif;
    
  switching(n, s, i+1);
  s(i) = -1;
  switching(n, s, i+1);
endfunction;

switching(numNodes, s, 1);