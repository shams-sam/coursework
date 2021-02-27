function f = directedStep(p1, p2, colorLine, colorPoint, headSize)
    hold on;
    dp = p1 - p2;
    q = quiver(p2(1), p2(2), dp(1), dp(2), 0);
    q.LineWidth = 1.5;
    q.MaxHeadSize = headSize;
    q.Color = colorLine;
    hold on;
    plot(p1(1), p1(2), colorPoint);
    hold on;
    plot(p2(1), p2(2), colorPoint);
end