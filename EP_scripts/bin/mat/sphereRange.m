function ranges = sphereRange(vx_pos1,diameter)
    ranges(1) = vx_pos1(1)-(diameter/2);
    ranges(2) = vx_pos1(1)+(diameter/2);
    ranges(3) = vx_pos1(2)-(diameter/2);
    ranges(4) = vx_pos1(2)+(diameter/2);
    ranges(5) = vx_pos1(3)-(diameter/2);
    ranges(6) = vx_pos1(3)+(diameter/2);
end
