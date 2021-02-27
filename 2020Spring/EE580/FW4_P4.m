clear all;
close all;
clc;

x = [0.4306 3.7094 6.9330 9.3582 4.7758 1.2910 4.83831 9.4560 3.6774 3.2849];
y = [7.7288 2.9727 1.7785 6.9080 2.6394 4.5774 8.43692 8.8150 7.0002 7.5569];
h1=plot(x, y, 'bs');
set(h1, 'markerfacecolor', get(h1, 'color'));
for i=1:length(x)
   text(x(i)+0.1,y(i)+0.1,string(i)); 
end

d = 1000;
epochs = 200;
n = 10;
k=1;
val = zeros(1, d);
valbest = zeros(1, epochs);
valavg = zeros(1, epochs);
valworst = zeros(1, epochs);
for i=1:d
    xi{k,i} = randperm(n);
    val(1,i) = eval(xi{k,i},x,y);
end
[valmin, argmin] = min(val);
best = xi{k, argmin};
valbest(1,k) = valmin;
valavg(1,k) = mean(val);
valworst(1,k) = max(val);

for k=1:epochs
    val = zeros(1, d);
    for i=1:d
        if i==argmin
            xi{k+1,i}=xi{k,i};
        else
            xi{k+1,i} = crossover(xi{k,i});
        end
        val(1,i) = eval(xi{k+1,i},x,y);
    end
    [valmin, argmin] = min(val);
    best = xi{k+1, argmin};
    valbest(1,k+1) = valmin;
    valavg(1,k+1) = mean(val);
    valworst(1,k+1) = max(val);
end

eval(best, x, y)

for i=2:length(best)
   directedStep([x(best(i)), y(best(i))], [x(best(i-1)),y(best(i-1))], 'k', 'bs', 0.0); 
end
directedStep([x(best(i)), y(best(i))], [x(best(1)),y(best(1))], 'k', 'bs', 0.0);

figure;
plot(valbest, 'ko-');
hold on;
plot(valavg, 'bs-');
hold on;
plot(valworst, 'rx-');
legend('best', 'average', 'worst');
xlabel('iterations');
ylabel('function value');

function sum = eval(order, x, y)
    sum = 0;
    for i=2:length(order)
       sum = sum + sqrt((x(order(i))-x(order(i-1)))^2 + (y(order(i))-y(order(i-1)))^2); 
    end
    sum = sum + sqrt((x(order(i))-x(order(1)))^2 + (y(order(i))-y(order(1)))^2); 
end

function x = crossover(y)
    x = y;
    v = randi(numel(y), 1, 2);
    x(v) = x(v([2, 1]));
end


