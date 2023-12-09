%% Program Initialization
% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
clear all; close all; clc;
% Index finger modeling(initial setting)
% Initial setting before main code starts
global data_stack time_stack                       

mydaq = daq.createSession('ni');
mydaq.Rate = 100;
mydaq.DurationInSeconds=10.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;
ch(1) = addAnalogInputChannel(mydaq,'Dev6',0,'Voltage');    %Left Flex Sensor
ch(2) = addAnalogInputChannel(mydaq,'Dev6',1,'Voltage');    %Right Flex Sensor
ch(1).Range = [-5 5];
ch(1).TerminalConfig = 'SingleEnded';
ch(2).Range = [-5 5];
ch(2).TerminalConfig = 'SingleEnded';
lh= addlistener(mydaq,'DataAvailable', @listener_callback_final); 
%%  Noise(Attenuation) and its stdev
 startForeground(mydaq);
 % Picking up the latest mydaq data
 data_stack = data_stack((mydaq.Rate*mydaq.DurationInSeconds)+1:end,:);
 % # of data
 leng=length(data_stack);
 % Mean
 meanData = mean(data_stack);
 Sumdata =zeros(1,2);
 Stdev   =zeros(1,2);
 for i= 1:leng
     Sumdata(1) = Sumdata(1) + (meanData(1) -data_stack(i,1))^2;            %Left  Sensor StDev
     Sumdata(2) = Sumdata(2) + (meanData(2) -data_stack(i,2))^2;            %Right Sensor StDev
 end
 %Standard Deviation of Each Voltages obtained from DAQ
 Stdev = sqrt(Sumdata/(leng-1)) 
%% Sensor calibration
% Left and Right finger modeling(calibration)
% Smart Sensors and IoT devices 23-1
% Name/ID: Jin Kwak/21900031

global time_stack data_stack mean_L mean_R
f = 440; d = 1; fs = 44100; no = d*fs;
t = (1:no)/fs; y = sin(2*pi*f*t);
sound(y, fs)                        %buzz
disp('Calibration start')
disp('손을 펴세요')

pause(2);

startForeground(mydaq);
open_data = [mean(data_stack(:,1)) mean(data_stack(:,2))];                              % Open set data of Left(:,1) and Right(:,2)
sound(y, fs)
disp('주먹을 쥐세요')
pause(2);
startForeground(mydaq);
data_stack = data_stack((mydaq.Rate*mydaq.DurationInSeconds)+1:end,:);                  % Picking up latest set(Close) of data
close_data = [mean(data_stack(:,1)) mean(data_stack(:,2))];                             % Mean calculation

sound(y, fs)
disp('Calibration finish')

stop(mydaq)
Left_data = [close_data(1,1) open_data(1,1)]    ;                                        % Left Flex Sensor Close Open
Right_data = [close_data(1,2) open_data(1,2)]   ;                                        % Right Flex Sensor Close Open
mean_L = (Left_data(1)+Left_data(2))/2          ;                                        % Left Sensor threshold 
mean_R = (Right_data(1)+Right_data(2))/2        ;                                        % Right Sensor threshold

                                         
%% Before track Start
%Before starting this main function
% Look at Left_data & Right_data
% to make sure close & open data varies
global V_L V_R time_stack mydaq                                                    % DAQ  
global FLAG_START Rate_Plot TYPE_TRACK mean_L mean_R avgV_R avgV_L flag            % CarModel medR & medL or avgV_R & avgV_L should be commented
fprintf('Program setting ')         ;
Rate_Plot = 20                      ;                                                                             
mydaq = daq.createSession('ni')     ;
mydaq.Rate = 1000                   ;  
mydaq.IsContinuous = 1              ;                                            % System is in progress until clear/clc/close                 
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/Rate_Plot     ;                % 50 data at once

ch0 = addAnalogInputChannel(mydaq, 'Dev6', 'ai0', 'Voltage')    ;                %Left
ch1 = addAnalogInputChannel(mydaq, 'Dev6', 'ai1', 'Voltage')    ;                %Right

ch0.Range = [-10.0 10.0];   ch0.TerminalConfig = 'SingleEnded'  ;
ch1.Range = [-10.0 10.0];   ch1.TerminalConfig = 'SingleEnded'  ;
lh = addlistener(mydaq, 'DataAvailable',@RunCarModel)           ;                    
fprintf('DONE\n\nREADY\n\n')                                    ;
%% Track Trial Start
% Available Track : A, B, C, D, E
TYPE_TRACK = 'C'                ;
StartCarModel(mydaq,TYPE_TRACK) ;
%% Track Trial Finish
FinishCarModel(mydaq,TYPE_TRACK); 
close all; 