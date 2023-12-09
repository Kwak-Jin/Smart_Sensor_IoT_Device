% startBackground week4 21900031 곽진
clear all; close all; clc;

global data_stack time_stack re_data_stack angle_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;
mydaq.DurationInSeconds=10.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

%=============================================2-2)=============================================%

ch(1) = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number
ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';   
ch(2) =addAnalogInputChannel(mydaq,'Dev2',1,'Voltage'); %mydaq, device number, pin number
ch(2).Range = [-10.0 10.0];
ch(2).TerminalConfig = 'SingleEnded';

lh = addlistener(mydaq,'DataAvailable', @listener_callback_week4_p2);

startBackground(mydaq);
%%
figure(1);
plot(time_stack,data_stack(:,1)); hold on; plot(time_stack,data_stack(:,2));
title('A and B channel signals of encoder');
xlabel('Time [sec]');
ylabel('Voltage [V]');
legend('channel A', 'channel B');
xlim([0 10]);
ylim([-0.5 5.5]);

%%
%=============================================2-4)=============================================%
k = 0;
Angle = zeros(length(time_stack),1);
Threshold = 2;                  %Threshold voltage
for i=2:length(data_stack)
    if data_stack(i,2) <= Threshold && data_stack(i-1,1) <= Threshold && data_stack(i,1) > Threshold
        k = k - 1;
        Angle(i,1) = k * 7.5;
    elseif data_stack(i,2) > Threshold && data_stack(i-1,1) > Threshold && data_stack(i,1) <= Threshold
        k = k - 1;
        Angle(i,1) = k * 7.5;

    elseif data_stack(i,2) > Threshold && data_stack(i-1,1) <= Threshold && data_stack(i,1) > Threshold
        k = k + 1;
        Angle(i,1) = k * 7.5;
    elseif data_stack(i,2) <= Threshold && data_stack(i-1,1) > Threshold && data_stack(i,1) <= Threshold
        k = k + 1;
        Angle(i,1) = k * 7.5;
    else
        Angle(i,1) = k * 7.5;
    end
end
figure(2);
plot(time_stack,Angle);
title('Encoder signal to Angle [Resolution: 7.5]');
xlabel('Time [sec]');
ylabel('Angle [degree]');
xlim([0 10]);

%%
%=============================================2-5)=============================================%

k=0;                            % Number of 
angle = zeros(length(time_stack),1);
Threshold= 2;                   %Threshold voltage

for i=2:length(data_stack)

    if (data_stack(i,1) <= Threshold) && (Threshold < data_stack(i,2)) && (data_stack(i-1,2) <= Threshold) 
        k = k + 1;          %A는 OFF상태, B는 TURNING ON => 반시계방향 
        angle(i,1)= k * 3.75;
    elseif (Threshold < data_stack(i,2)) && (data_stack(i-1,1) <= Threshold) && (Threshold < data_stack(i,1))
        k = k + 1;          %B는 ON상태, A가 TURNING ON => 반시계방향
        angle(i,1)= k*3.75;
    elseif (Threshold < data_stack(i,1)) && (Threshold < data_stack(i-1,2)) && (data_stack(i,2) <= Threshold)
        k = k+1;            %A는 ON상태, B가 TURNING OFF => 반시계방향
        angle(i,1)= k*3.75;
    elseif (data_stack(i,2) <= Threshold) && (Threshold < data_stack(i-1,1)) && (data_stack(i,1) <= Threshold) 
        k = k+1;            %B는 OFF상태, A가 TURNING OFF => 반시계방향
        angle(i,1)= k * 3.75;
    
    elseif (data_stack(i,2)) <= Threshold && (Threshold < data_stack(i,1)) && (data_stack(i-1,1) <= Threshold) 
        k = k - 1;          %B는 OFF상태, A는 TURNING ON => 시계방향 
        angle(i,1)= k*3.75;
    elseif (Threshold < data_stack(i,1)) && (data_stack(i-1,2) <= Threshold) && (Threshold < data_stack(i,2))
        k = k - 1;          %A는 ON상태, B가 TURNING ON => 시계방향
        angle(i,1)= k*3.75;
    elseif (Threshold < data_stack(i,2)) && (Threshold < data_stack(i-1,1)) && (data_stack(i,1) <= Threshold)
        k = k - 1;            %B는 ON상태, A가 TURNING OFF => 시계방향
        angle(i,1)= k*3.75;
    elseif (data_stack(i,1) <= Threshold) && (Threshold < data_stack(i-1,2)) && (data_stack(i,2) <= Threshold) 
        k = k - 1;            %A는 OFF상태, B가 TURNING OFF => 시계방향
        angle(i,1)= k*3.75;
    else
        angle(i,1)= k*3.75;
    end
end
figure(3);
plot(time_stack,angle); hold on; grid on;
plot(time_stack,data_stack(:,1),'r'); plot(time_stack,data_stack(:,2),'g');
legend('Angle', 'Channel A signal', 'Channel B signal');
title('Encoder signal to Angle [Resolution: 3.75]');
xlabel('Time [sec]');
ylabel('Angle [degree]');
xlim([0 10]);
