%%StartForeground
%=========================================================================%
% Handong Global University
% Smart Sensors and IoT Devices 
% About     : Angle Estimation of Pendulum using Accelerometer, Gyroscope
%             and Potentiometer
% Author    : 곽진, 이찬용
% Created   : 2023.04.07
% Modified  : 2023.04.26
%=========================================================================%
clear all; close all; clc;
global data_stack time_stack G_angle_stack G_angledot_stack A_angle_stack P_angle_stack CF_angle_stack KF_angle_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;                                   
mydaq.DurationInSeconds=5.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch2 = addAnalogInputChannel(mydaq,'Dev4',2,'Voltage'); %Gyroscope           data_stack(:,1)
ch1 = addAnalogInputChannel(mydaq,'Dev4',1,'Voltage'); %Accelerometer y     data_stack(:,2) 
ch4 = addAnalogInputChannel(mydaq,'Dev4',0,'Voltage'); %Accelerometer x     data_stack(:,3)
ch3 = addAnalogInputChannel(mydaq,'Dev4',3,'Voltage'); %Potentiometer       data_stack(:,4)
ch1(1).Range = [-10.0 10.0];
ch1(1).TerminalConfig = 'SingleEnded';
ch2(1).Range= [-10.0 10.0];
ch2(1).TerminalConfig = 'SingleEnded';
ch3(1).Range= [-10.0 10.0];
ch3(1).TerminalConfig = 'SingleEnded';
ch4(1).Range= [-10.0 10.0];
ch4(1).TerminalConfig = 'SingleEnded';

lh= addlistener(mydaq,'DataAvailable', @listener_callback_p1_1);
startForeground(mydaq);

%%
close all;
figure(1);
plot(time_stack,KF_angle_stack,'r'); hold on; grid on;
plot(time_stack, CF_angle_stack,'b');
plot(time_stack,P_angle_stack,'c'); 
legend('Kalman','Complementary','Potentiometer');
xlabel('Time [Sec]');
ylabel('Angle [degree]');
title('Filter Data - Stationary')
fig1= figure(1);
movegui(fig1,'east');

figure(2);
plot(time_stack, P_angle_stack,'r'); hold on; grid on;
plot(time_stack, G_angle_stack,'b');
plot(time_stack, A_angle_stack,'c');
legend('Potentiometer','Gyroscope','Accelerometer');
title('Raw Data - Fast Stationary');
xlabel('Time [Sec]');
ylabel('Angle [degree]');
fig2= figure(2);
movegui(fig2, 'west');

%%
% Kalman Filter with different Noise model
dt= 0.01;
A = [1 dt;
     0 1];
H = [1 0];
sig_process = 10;
sig_gyro = 10;
plot(time_stack,P_angle_stack,'LineWidth',2); hold on; grid on;
for sig_acc = 1:1:1000
    Q = [(sig_process)^2       0;
             0               (sig_gyro)^2];
    R = (sig_acc)^2;
    Theta_= zeros(2,1);
    P_p= A * 100 *A' + Q;
    Theta_p = zeros(2,1);
    KF(1,1) = 0;
    Rsum=0;
    for i = 2: length(P_angle_stack)    
              %Priori (Predictor)
              Theta_ = A * [Theta_p(1,1) ; G_angledot_stack(i,1)];
              P_k = A * P_p* A' + Q;

              %Posterior (Corrector)
              K = P_k * H' * inv(H * P_k * H' + R);
              Theta_p = Theta_ + K*(A_angle_stack(i,1) -H * Theta_);
              P_p = (eye(2) - K * H) * P_k * (eye(2)- K* H)' + K * R * K';
              KF_angle_stack(i,1) = Theta_p(1,1);  
              Rsum = Rsum + (P_angle_stack(i,1)- KF_angle_stack(i,1))^2;
    end
    plot(time_stack,KF_angle_stack);
    buffer.RMSE(sig_acc,1) = sqrt(Rsum/length(P_angle_stack));
end
%%
%%
figure(1); hold on;
plot(time_stack,)