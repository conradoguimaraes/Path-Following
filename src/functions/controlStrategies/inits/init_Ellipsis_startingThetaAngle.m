fprintf("Running 'init_Ellipsis_startingThetaAngle.m'\n")
if (state == 0 || state == 2)
    th0 = -pi;
else
    th0 = 0;
end
th0 = 0; %forcing theta = 0 (ignore states)