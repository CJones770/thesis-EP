%function(s) converting mm to voxel space and visa versa
function mm_pos = vox2mm(pos_vox)
    mm_pos(1) = (-pos_vox(1) * 2) + 90;
    mm_pos(2) = (pos_vox(2) * 2) - 126;
    mm_pos(3) = (pos_vox(3) * 2) - 72;
end
