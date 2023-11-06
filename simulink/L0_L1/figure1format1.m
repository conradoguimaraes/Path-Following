xlabel('X')
ylabel('Y')
zlabel('Z')
hold all
lightGrey = 0.8*[1 1 1];
surface(rs.*xs,rs.*ys,rs.*zs,'FaceColor', 'none','EdgeColor',lightGrey)
axis equal; 
title("Figure 1")