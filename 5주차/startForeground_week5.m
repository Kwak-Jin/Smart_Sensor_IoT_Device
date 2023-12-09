% startForeground
clc;close all; clear all;
global data_stack time_stack angle_stack AVel_stack mAngVel

mydaq= daq.createSession('ni');
mydaq.Rate= 1000;                                   
mydaq.DurationInSeconds=10.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';

lh= addlistener(mydaq,'DataAvailable', @listener_callback_week5_p1); 
startForeground(mydaq);

%%
X= [-120  0.2498
    -100  0.3827;
    -80   1.0472;
    -60   1.3037;
    -40   2.0055;
    -20   2.2406;
    0     2.6338;         
    20    3.0739;
    40    3.3420;
    60    3.8210;
    80    4.0979;
    100   4.6119;
    120   4.8220];      

angle=X(:,1);
voltage=X(:,2);
Coeff=polyfit(voltage,angle,1);
%%
plot(time_stack,AVel_stack); %hold on; plot(time_stack,mAngVel);
%legend('Median Filtered Angular Velocity','Angular Velocity');
title('Angular velocity of Potentiometer (Unfiltered)');
xlabel('Time [sec]'); ylabel('Angular velocity [deg/s]');

%%
%Two-point Central Derivative Method
%Check
ANGPrime= zeros(length(angle_stack),1);
for i=2:length(ANGPrime)-1
    ANGPrime(i,1)= (angle_stack(i+1)-angle_stack(i-1))*500;
end
 
hold on; plot(time_stack,ANGPrime);
plot(time_stack,AVel_stack); plot(time_stack,mAngVel);
xlabel('Time [sec]');
ylabel('Angular velocity [degree/s]');
legend('2-point central','2-point backward','Median Filtered');
