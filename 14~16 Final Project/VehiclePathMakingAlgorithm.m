%% Vehicle path making algorithm
%==============================%
% Smart Sensors and IoT devices
% Creator : Jin Kwak
% Created : 2023.06.13
% Modified: 2023.06.14 
%==============================%
% Initial Angle should be therefore 2nd point is straight upwards
% Valid ginput to make appropriate map model
% Reference frame to Body Frame
% Calculate tangent (dY/dX) for heading angle
clear all; clc; close all;
FIG1= figure('Name','Vehicle_Path_Making');
movegui(FIG1,'center');
hold on; grid on;
i = 1;             % Initial Point
xlim([0 200]);     % Arbitrary limit
ylim([0 200]);     
roadWidth= 5;      %Width
while true         %Points you choose
    enableDefaultInteractivity(gca); 
    [xdata, ydata] = ginput(1); 
    coordinates(i,:) = [xdata, ydata];  
    
    % Condition for break loop
    % Double Click ==> Finish
    if i > 1
        if abs(coordinates_temp(1) - coordinates(i,1)) <= 0.0000001 && abs(coordinates_temp(2) - coordinates(i,2)) <= 0.0000001
            break
        end
    end
    % Points are plotted with Red Point
    plot_with_style(coordinates(i,1),coordinates(i,2),'rp',1, 7);
    % Previous point is saved to compare
    coordinates_temp = coordinates(i,:);
    i = i + 1;

end
hold off;
close all;
coordinates(end,:) = [];
% Linspace making in between range
xq             = linspace(floor(min(coordinates(:,1))), ceil(max(coordinates(:,1))), 100);
% Modified Akima Interpolation
p              = makima(coordinates(:,1),coordinates(:,2),xq);
FIG2 = figure(2);
plot(xq,p);         
movegui(FIG2,'north');

% Present Date
date = datestr(now,'mmdd'); 
TextTitle =strcat('Track ', date);

%Replicating progress
TrackData(:,1) = [xq';xq']; 
TrackData(:,2) = [p';p'];

for i= 1:99
    dY = (TrackData(i+1,2)-TrackData(i,2));
    dX = (TrackData(i+1,1)-TrackData(i,1));
    HeadingAngle(i)=atan2(dY,dX);               %Angle From Current Point to Next Point
end
HeadingAngle(100) =HeadingAngle(99);            %Last Angle is Same as Last-1 Angle
for i= 1: 100
    %Data is replicated
    TrackData(101-i,1) = TrackData(100+i,1);    
    TrackData(101-i,2) = TrackData(100+i,2);
    % Coordinate Change 
    GET_DCM= GETDCM(HeadingAngle(i));
    TrackData(101-i,:) = ((GET_DCM)*(TrackData(101-i,:))' - roadWidth/2*[0 ; 1])'     ;     
    TrackData(100+i,:) = ((GET_DCM)*(TrackData(100+i,:))' + roadWidth/2*[0 ; 1])'     ;       
    % Coordinate Change Back
    TrackData(101-i,:) = ((GET_DCM)'*TrackData(101-i,:)')';
    TrackData(100+i,:) = ((GET_DCM)'*TrackData(100+i,:)')';
end
% Calibration to correct Coordinate is required 
LineData_Start=[TrackData(1,:);
                TrackData(1,1) TrackData(1,2)+1.5];
LineData_Fin  =[TrackData(end,:);
                TrackData(end,1) TrackData(end,2)+1.5];
filestore.LineData_Fin = LineData_Fin;
filestore.LineData_Start = LineData_Start;
filestore.TextTitle =  TextTitle;
filestore.TrackData= TrackData;
filestore.ValueOutPos = [floor(min(TrackData(:,1))) floor(min(TrackData(:,2))) ceil(max(TrackData(:,1))) ceil(max(TrackData(:,2)))] ;

%File is stored
filename = strcat('TrackData_Track', date, '.mat');
save(filename,'-struct','filestore');
figure(3);
plot(TrackData(:,1),TrackData(:,2));
FIG3= figure(3);
movegui(FIG3,'center');
