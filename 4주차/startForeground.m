% startForeground week4 21900031 곽진
clear all; close all; clc;

global data_stack time_stack angle_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;                                   
mydaq.DurationInSeconds=10.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;
angle=0;

ch = addAnalogInputChannel(mydaq,'Dev8',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';

lh= addlistener(mydaq,'DataAvailable', @listener_callback_week4_p1); 
startForeground(mydaq);

%%
%=============================================1-2)=============================================%
k=0;
totalrotation= zeros(length(time_stack),1);

for i=2:length(time_stack)
    if data_stack(i-1,1)< 1.5 && data_stack(i,1)>1.5 || data_stack(i-1,1)>1.5 && data_stack(i,1)<1.5        %threshold value is 1.5V for rising
        k=k+1;
        totalrotation(i,1)= totalrotation(i-1,1)+7.5;       %rotation angle is updated by adding 7.5
    else
        totalrotation(i,1) = totalrotation(i-1,1);          %Otherwise, rotation angle is same as last value
    end
end

figure(1); plot(time_stack,data_stack,'r-');
title('Pulse of encoder in time');
xlabel('Time [sec]');
ylabel('Pulse [V]');
figure(2); plot(time_stack,totalrotation,'b-');
title('Angle derived from encoder pulse');
xlabel('Time [sec]');
ylabel('Angle [deg]');