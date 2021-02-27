function c1 = mutation(p1, pm, res)
    c1 = [d2b(p1(1), -5, 5, res/2), d2b(p1(2), -5, 5, res/2)];
    for i = 1:length(p1)
        if rand < pm
           p1(i) = 1-p1(i); 
        end
    end
    c1 = [b2d(c1(1:res/2),-5,5,res/2); b2d(c1((res/2)+1:res),-5,5,res/2)];
end