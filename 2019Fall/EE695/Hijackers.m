% Names and connections between 9/11 Hijackers
% Data from "Mappng Networks of Terrorist Cells" by Krebs, Connections 24(3): 43-52, 2002

names = {
'Wail Alshehri';
'Satam Suqami';
'Waleed Alshehri';
'Raed Hijazi';
'Nabil al-Marabh';
'Ahmed Alghamdi';
'Mohand Alshehri';
'Fayez Ahmed';
'Mustafa Ahmed al-Hisawi';
'Abdul Aziz Al-Omari';
'Saeed Alghamdi';
'Ahmed Al Haznawi';
'Hamza Alghamdi';
'Ahmed Alhami';
'Mohamed Abdi';
'Abdussattar Shaikh';
'Nawaf Alhazmi';
'Osama Awadallah';
'Khalid Al-Mihdhar';
'Salem Alhazmi';
'Marwan Al-Shehhi';
'Mamoun Darkazanli';
'Zakariya Essabar';
'Said Bahaji';
'Mounir El Motassadeq';
'Zacarias Moussaoui';
'Ramzi Bin al-Shibh';
'Agus Budiman';
'Ahmed Khalil Ibrahim Samir Al-Ani';
'Mohamed Atta';
'Ziad Jarrah';
'Lotfi Raissi';
'Hani Hanjour';
'Rayed Mohammed Abdullar';
'Bandar Alhazmi';
'Faisal Al Salmi';
'Majed Moqed'};


conns = [
  1 2;
  1 3;
  2 3;
  2 4;
  2 5;
  3 9;
  3 10;
  4 5;
  4 11;
  5 6;
  5 11;
  6 13;
  7 8;
  7 13;
  8 9;
  8 21;
  9 21;
  9 30;
  10 21;
  10 30;
  11 12;
  11 13;
  11 14;
  11 17;
  12 13;
  12 31;
  13 14;
  13 17;
  14 17;
  15 17;
  16 17;
  16 18;
  16 19;
  17 18;
  17 19;
  17 20;
  17 30;
  17 33;
  18 19;
  19 33;
  20 21;
  20 31;
  21 22;
  21 23;
  21 24;
  21 25;
  21 27;
  21 28;
  21 30;
  21 31;
  21 32;
  21 33;
  22 30;
  22 24;
  23 24;
  23 27;
  23 30;
  23 31;
  24 25;
  24 27;
  24 30;
  24 31;
  25 27;
  25 30;
  26 27;
  26 30;
  27 28;
  27 30;
  27 31;
  28 30;
  28 31;
  29 30;
  30 31;
  30 32;
  30 33;
  31 32;
  31 33;
  32 33;
  32 34;
  33 34;
  33 35;
  33 36;
  33 37;
  34 35;
  34 36
  ];

A = zeros(37,37);
for i = 1:length(conns)
  A(conns(i,1),conns(i,2)) = 1;
end

A = A + A';
numNodes = size(A)(1);

disp("Degree Centrality:\n")
degreeCentrality = A*ones(numNodes, 1);
[degreeCentralitySorted, sortedInds] = sort(degreeCentrality(:),'descend');
top3Degree = sortedInds(1:3);
for i = sortedInds
  disp(i);
  disp(names(i));
  disp(degreeCentralitySorted);
endfor

disp("\n Eigenvector Centrality:\n")
[V, D] = eig(A);
[_, max_idx] = max(diag(D));
eigenvectorCentrality = V(:,max_idx);
[eigenvectorCentralitySorted, sortedInds] = sort(eigenvectorCentrality(:), 'descend');
top3Eigen=sortedInds(1:3);
for i = sortedInds
  disp(i);
  disp(names(i));
  disp(eigenvectorCentralitySorted);
endfor

disp("\nPage Rank:\n")
alpha = 0.85;
s = ones(num_nodes, 1);
D = diag(degreeCentrality);
pageRank = inv(eye(num_nodes) - alpha * A * inv(D)) * (1-alpha) * s;
[pageRankSorted, sortedInds] = sort(pageRank(:), 'descend');
top3PageRank = sortedInds(1:3);
for i = sortedInds
  disp(i);
  disp(names(i));
  disp(pageRankSorted);
endfor

disp("\nCloseness Centrality:\n")
minDist = zeros(num_nodes, num_nodes);
visited = zeros(num_nodes, num_nodes);
iLenPaths = eye(num_nodes, num_nodes);
for i = 1:num_nodes
  iLenPaths = iLenPaths*A;
  for r = 1:num_nodes
    for c = r+1:num_nodes
      if visited(r,c) == 1
        continue;
      endif
      if iLenPaths(r, c) > 0
        minDist(r,c) = i;
        minDist(c,r) = i;
        visited(r,c) = 1;
      endif
    endfor
  endfor
endfor
minDist = minDist * ones(num_nodes, 1);
closenessCentrality = (num_nodes-1)./minDist;
[closenessCentralitySorted, sortedInds] = sort(closenessCentrality(:), 'descend');
top3Close = sortedInds(1:3);
for i = sortedInds
  disp(i);
  disp(names(i));
  disp(closenessCentralitySorted);
endfor
