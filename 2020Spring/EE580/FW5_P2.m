clear all;
close all;
clc;

x1 = linspace(-5, 5, 100);
x2 = linspace(-5, 5, 100);

[X1, X2] = meshgrid(x1, x2);

Z = zeros(size(X1));

for idx = 1: size(Z,1)
    for c = 1: size(Z, 2)
        x_i = [X1(idx,c), X2(idx,c)]';
        Z(idx,c) = griewank(x_i);
    end
end

figure;
contour(X1, X2, Z, 10, '--');

d = 200;
epochs = 50;
dim = 2;

L = 32;
pm = 0.01;
pc = 0.75;

valbest = zeros(1,epochs);
valavg = zeros(1,epochs);
valworst = zeros(1,epochs);

k = 1;
for i=1:d
    P{k,i} = random('uniform', -5, 5, [dim, 1]);
    f(1,i) = griewank(P{k,i}); 
end
F = sum(f);
p = f./F;
valbest(1,k) = min(f);
valavg(1,k) = mean(f);
valworst(1,k) = max(f);

for k=1:epochs
    for i=1:d
        a = randi([1, d]);
        if p(a) < p(i)
            M{i} = P{k,a};
        else
            M{i} = P{k,i};
        end
    end
    rand_selection = randperm(d);
    for i=1:2:d
       [P{k+1,i}, P{k+1,i+1}] = crossover_real(M{rand_selection(i)}, ...
           M{rand_selection(i+1)}, pc);
       f(1,i) = griewank(P{k+1,i});
       f(1,i+1) = griewank(P{k+1,i+1});
    end
    for i=1:d
       P{k+1,i}= mutation_real(P{k+1,i}, pm); 
       f(1,i) = griewank(P{k+1,i});
    end
    F = sum(f);
    p = f./F;
    [valbest(1,k+1), bestidx] = min(f);
    valavg(1,k+1) = mean(f);
    valworst(1,k+1) = max(f);
end
x_star = P{k+1, bestidx};
hold on;
plot(x_star(1), x_star(2), 'rx');

figure;
plot(valbest, 'ko-');
hold on;
plot(valavg, 'bs-');
hold on;
plot(valworst, 'rx-');
legend('best', 'average', 'worst');
xlabel('iterations');
ylabel('function value');

function [c1, c2] = crossover_real(p1, p2, pc)
    if rand > pc
        c1 = p1;
        c2 = p2;
    else
        alpha = rand;
        c1 = alpha*p1 + (1-alpha)*p2;
        c2 = (1-alpha)*p1 + alpha*p2;
    end    
end

function c1 = mutation_real(p1, pm)
    c1 = p1;
    if rand < pm
       alpha = rand;
       dim = size(p1);
       w = random('uniform', -5, 5, dim);
       c1 = alpha*p1 + (1-alpha)*w;
    end
end

