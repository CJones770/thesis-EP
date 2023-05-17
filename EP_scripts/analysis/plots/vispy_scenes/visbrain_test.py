import numpy as np
import visbrain as vb
from visbrain.objects import BrainObj, SceneObj, SourceObj

ROI_list = open('/media/corey/4TB-WDBlue/data-thesis/ROI_list.txt')
ROIs = ROI_list.readlines()

#Read in list of Max F coordinates from subject directories
All_points_to_plot1 = []
All_points_to_plot2 = []
labels = []
scenes = []
for roi in ROIs:
    roi = roi.strip()
    labels.append(roi)
    points_to_plot = []
    points_to_plot2 = []
    F1_list = open('/media/corey/4TB-WDBlue/data-thesis/fMRI/Rapidtide_concatenated_positions/F1/%s_mmconcat.txt' %roi)
    F2_list = open('/media/corey/4TB-WDBlue/data-thesis/fMRI/Rapidtide_concatenated_positions/F2/%s_mmconcat.txt' %roi)
    F1_coords = F1_list.readlines()
    F2_coords = F2_list.readlines()
    #Frequency Band 1
    stripped_dmPFC = [s.strip() for s in F1_coords]
    split_stripped = [s.split() for s in stripped_dmPFC]
    #Frequency Band 2
    stripped_dmPFC2 = [s.strip() for s in F2_coords]
    split_stripped2 = [s.split() for s in stripped_dmPFC2]


    for n in range(0,len(F1_coords)-1):
        f_dmPFC = [float(s) for s in split_stripped[n]]
        points_to_plot.append(np.array(f_dmPFC))
        f_dmPFC_2 = [float(s) for s in split_stripped2[n]]
        points_to_plot2.append(np.array(f_dmPFC_2))

    All_points_to_plot1.append(np.array(points_to_plot))
    All_points_to_plot2.append(np.array(points_to_plot2))

print(labels)

for r, roi in enumerate(ROIs):
#Defining source and brain objects
    b_obj = BrainObj('B1')

    s_obj = SourceObj('%s' %roi, All_points_to_plot1[r])
    s_obj_2 = SourceObj('%s' %roi, All_points_to_plot2[r],color='blue')
#Black background scene
    sc = SceneObj(bgcolor='black')

    sc.add_to_subplot(b_obj,row=0,col=0)
    sc.add_to_subplot(s_obj,row=0,col=0)
    sc.add_to_subplot(s_obj_2,row=0,col=0)
    sc.screenshot('/media/corey/4TB-WDBlue/data-thesis/fMRI/imagesMaxF/%s_MaxF.png' %roi,autocrop=True)