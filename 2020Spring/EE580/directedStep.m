function f = directedStep(p1, p2, t1, t2)
    hold on;
    dp = p1 - p2;
    quiver(p2(1), p2(2), dp(1), dp(2), 0);
    text(p1(1),p1(2), sprintf('(%d)',t1));
    text(p2(1),p2(2), sprintf('(%d)',t2));   
end