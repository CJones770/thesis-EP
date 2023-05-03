function vox_pos = mm2vox(pos_mm)
    vox_pos(1) = round((-pos_mm(1) + 90) / 2);
    vox_pos(2) = round((pos_mm(2) + 126) / 2);
    vox_pos(3) = round((pos_mm(3) + 72) / 2);
end
