
xyCoords = [0,-52;-1,54;-46,-66;49,-63]; %[90,74;89,180;44,60;139,63];

xyLabs = {'PCC';'mPFC';'LlPar';'RlPar'};
xyRadii = [3;4;4;4];

xyinfo = cell(5,4);
for r=1:5
%xyinfo{r,1} = xyCoords(r,1);
%xyinfo{r,2} = xyCoords(r,2);
%xyinfo{r,3} = xyLabs{r,1};
%xyinfo{r,4} =xyRadii(r,1);
end

for r=1:4
    hold on
    for c=1:4
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
            arrow = plot_arrow(newx1,newy1,newx2,newy2); %Black arrow for negative
            end
            if xyCoords(c,2) > xyCoords(r,2)
            newy1 = xyCoords(r,2) - (xyRadii(r) * sin(theta1));
            newy2 = xyCoords(c,2) - (xyRadii(c) * sin(theta2));  
            arrow = plot_arrow(newx1,newy1,newx2,newy2); %Black arrow for negative
            end       
    end
     viscircles(xyCoords(r,:),xyRadii(r))
     text(xyCoords(r,1),xyCoords(r,2),xyLabs(r))
end
hold off