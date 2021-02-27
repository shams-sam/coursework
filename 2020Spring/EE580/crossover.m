function [c1, c2] = crossover(p1, p2, pc, res)
    if rand > pc
        c1 = p1;
        c2 = p2;
    else
        p1 = [d2b(p1(1), -5, 5, res/2), d2b(p1(2), -5, 5, res/2)];
        p2 = [d2b(p2(1), -5, 5, res/2), d2b(p2(2), -5, 5, res/2)];
        r = randi([1, res]);
        c1 = [p1(1:r), p2(r+1: res)];
        c2 = [p2(1:r), p1(r+1: res)];
        c1 = [b2d(c1(1:res/2),-5,5,res/2); b2d(c1((res/2)+1:res),-5,5,res/2)];
        c2 = [b2d(c2(1:res/2),-5,5,res/2); b2d(c2((res/2)+1:res),-5,5,res/2)];
    end    
end