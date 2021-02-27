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

d = 1000;
epochs = 100;
dim = 2;

w = 0.5;
c1 = 2;
c2 = 2.1;
kappa = 0.729;
k = 1;
val = zeros(1,d);

valbest = zeros(1,epochs);
valavg = zeros(1,epochs);
valworst = zeros(1,epochs);
gbest = zeros(1, epochs);

for i=1:d
    x{k,i} = random('uniform', -5, 5, [dim, 1]);
    v{k,i} = random('uniform', -1, 1, [dim, 1]);
    p{k,i} = x{k,i};
    val(1,i) = griewank(p{k,i});
end
[~,maxidx] = max(val);
g{k} = x{k,maxidx};
for k=1:epochs
    val = zeros(1, d);
    for i=1:d
        r{k,i} = random('uniform', -1, 1, [dim, 1]);
        s{k,i} = random('uniform', -1, 1, [dim, 1]);
        v{k+1, i} = kappa*(v{k,i} + c1*r{k,i}.*(p{k,i}-x{k,i}) + ...
            c2*s{k,i}.*(g{k}-x{k,i}));
        x{k+1,i} = x{k,i} + v{k+1, 1};
        x{k+1,i} = clamp(x{k+1, i}, -5, 5);
        if griewank(x{k+1, i}) > griewank(p{k,i})
            p{k+1,i} = x{k+1,i}; 
        else
            p{k+1,i} = p{k,i};
        end
        val(1,i) = griewank(p{k+1,i});
    end
    
    [maxval,maxidx] = max(val);
    valbest(1,k) = maxval;
    valavg(1,k) = mean(val);
    valworst(1,k) = min(val);
    g{k+1} = p{k+1, maxidx};
end
x_star = g{k+1};
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