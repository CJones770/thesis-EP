%plotting arrows based on EC values

GroupAverage_EC = bma_1.Ep(1:441);

pc_diffEC = bma_1.Ep(883:1323);

%Variance
Group_var = diag(bma_1.Cp); 

X0_var = Group_var(1:441);
pc_var = Group_var(883:1323);
%Store only statistically differentiable from 0 values
tvalsX0 = abs(GroupAverage_EC / sqrt(X0_var/num_subs));
tvalsPatCon = abs(pc_diffEC / sqrt(pc_var / num_subs));

for r=1:441
    if tvalsX0(r) < 2
        GroupAverage_EC(r) = 0;
    end
    if tvalsPatCon(r) < 2
        pc_diffEC(r) = 0;
    end
end

%Reshape EC and Cov values to be 21x21 matrices
resX0EC = reshape(GroupAverage_EC,21,21);
res_pcDiffEC = reshape(pc_diffEC,21,21);
resX0var = reshape(X0_var,21,21);
res_pcDiffvar = reshape(pc_var,21,21);

%test_arr = plot_arrow(55.6934,-52.8175,8,54,'linewidth',bma_test.Ep(5,1));
xyCoords = [0,-52;-1,54;-46,-66;49,-63;-61,-24;58,-24;0,-12;-25,-81;25,-81;0,24;-44,45;44,45;-50,-51;50,-51;0,21;-35,45;32,45;-41,3;41,3;-62,-45;62,-45];
xyLabs = {'PCC';'mPFC';'LlPar';'RlPar';'LiTem';'RiTem';'mdThal';'LpCer';'RpCer';'dmPFC';'LaPFC';'RaPFC';'LsPar';'RsPar';'dACC';'LaPFCsn';'RaPFCsn';'LIns';'RIns';'LlParSN';'RlParSN'};
xyRadii = [3;4;4;4;4;4;3;2;2;4;4;4;4;4;3;4;4;3;3;4;4];

xyinfo = cell(21,4);
for r=1:21
xyinfo{r,1} = xyCoords(r,1);
xyinfo{r,2} = xyCoords(r,2);
xyinfo{r,3} = xyLabs{r,1};
xyinfo{r,4} =xyRadii(r,1);
end
count = 0;
title('patient vs control [0.01 - 0.027Hz]');
for r=1:num_ROIs
    hold on
    for c=1:num_ROIs 
            a = xyCoords(r,1) - xyCoords(c,1); %diff in x coords
            b = xyCoords(r,2) - xyCoords(c,2); %diff in y coords
            h = sqrt(a^2 + b^2); %(xyCoords(r,2)-xyCoords(c,2))^2); %hypotenuse
            theta1 = asin(a/h); %angle
            theta2 = pi/2 - theta1; 
            newx1 = xyCoords(r,1) + (xyRadii(r) * cos(theta1));
            newx2 = xyCoords(c,1) + (xyRadii(c) * cos(theta2)); 
            if xyCoords(c,2) < xyCoords(r,2) 
            newy1 = xyCoords(r,2) - (xyRadii(r) * sin(theta1));
            newy2 = xyCoords(c,2) + (xyRadii(c) * sin(theta2));
            end
            if xyCoords(c,2) > xyCoords(r,2)
            newy1 = xyCoords(r,2) - (xyRadii(r) * sin(theta1));
            newy2 = xyCoords(c,2) - (xyRadii(c) * sin(theta2));  
            end
        if res_pcDiffEC(r,c) ~= 0
            count = count +1;
            if res_pcDiffEC(r,c) > 0
            arrow = plot_arrow(newx1,newy1,newx2,newy2,'linewidth',res_pcDiffEC(r,c),'color',[0 1 0],'facecolor',[0 1 0]); %Green arrow for positive
            end
            if res_pcDiffEC(r,c) < 0
            arrow = plot_arrow(newx1,newy1,newx2,newy2,'linewidth',res_pcDiffEC(r,c),'color',[0 0 0]); %Black arrow for negative
            end
        end
    end
     viscircles(xyCoords(r,:),xyRadii(r))
     text(xyCoords(r,1),xyCoords(r,2),xyLabs(r))
end
hold off

%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%title('Group Average');
%for r=1:num_ROIs
%    hold on
%    for c=1:num_ROIs 
%       if resX0EC(r,c) ~= 0
%            if resX0EC(r,c) > 0
%            arrow = plot_arrow(xyCoords(r,1),xyCoords(r,2),xyCoords(c,1),xyCoords(c,2),'linewidth',resX0EC(r,c),'color',[0 1 0],'facecolor',[0 1 0]); %Green arrow for positive
%            end
%            if res_pcDiffEC(r,c) < 0
%            arrow = plot_arrow(xyCoords(r,1),xyCoords(r,2),xyCoords(c,1),xyCoords(c,2),'linewidth',resX0EC(r,c),'color',[0 0 0]); %Black arrow for negative
%            end
%        end
%    end
%     viscircles(xyCoords(r,:),xyRadii(r))
%     text(xyCoords(r,1),xyCoords(r,2),xyLabs(r))
%end