clear all; close all; clc;

function Makecircle(a,b,r)
    theta= 0:0.01:360;
    x= a+r*cosd(theta);
    y= b+r*sind(theta);
    
    plot(x,y,'k',a,b,'ko')
    xlim([a-r-1 a+r+1]);
    ylim([b-r-1 b+r+1]);
end