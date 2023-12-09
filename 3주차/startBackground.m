    % startBackground
%=======================================================2======================================================%
clear all; close all; clc;
global data_stack time_stack angle angMAF

mydaq= daq.createSession('ni');
mydaq.Rate= 1000;
mydaq.DurationInSeconds=20.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev8',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';   

lh = addlistener(mydaq,'DataAvailable', @listener_callback_week3_p2); 
startBackground(mydaq);

%%
n = 10;
% window size 10
for i = 1:n-1
    ang10(i,1) = angle(i,1); 
end
for i = n:length(data_stack)
    ang10(i,1) = sum(angle(i-n+1:i))/n;
end
% window size 20
for i = 1:19
    ang20(i,1) = angle(i);
end
for i = 20:length(angle)
    ang20(i,1) = sum(angle(i-19:i,1))/20;
end
% window size 50
for i= 1:49
    ang50(i,1)= angle(i);
end
for i= 50:length(angle)
    ang50(i,1) = sum(angle(i-49:i))/50;
end
plot(time_stack,angle,'b'); hold on; grid on;
plot(time_stack,angMAF,'r');
plot(time_stack,ang10,'g');
plot(time_stack,ang20,'c');
plot(time_stack,ang50,'k');
title('Filter Perfomance of different window size');
ylabel('Angle [degree]');
xlabel('Time [sec]');
legend('Raw data', 'Size:5','Size:10','Size:20','Size:50');