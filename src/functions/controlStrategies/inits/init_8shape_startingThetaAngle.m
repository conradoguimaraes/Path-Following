fprintf("Running 'init_8shape_startingThetaAngle.m'\n")
if (state == 3 || state == 4 || state == 2)
    th0 = -pi;
else
    th0 = 0;
end
th0 = 0; %forcing theta = 0 (ignore states)