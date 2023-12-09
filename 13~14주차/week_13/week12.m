clear all; close all; clc;
% Index finger modeling(initial setting)
global data_stack time_stack trigger_stack deg_stack filtered_deg_stack open_data close_data firstRun size                                 
mydaq = daq.createSession('ni');
mydaq.Rate = 100;
mydaq.DurationInSeconds=5.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;
ch(1) = addAnalogInputChannel(mydaq,'Dev5',0,'Voltage');
ch(2) = addAnalogInputChannel(mydaq,'Dev5',1,'Voltage');
ch(1).Range = [-5 5];
ch(1).TerminalConfig = 'SingleEnded';
ch(2).Range = [-5 5];
ch(2).TerminalConfig = 'SingleEnded';


lh= addlistener(mydaq,'DataAvailable', @listener_callback_final); 
firstRun1 = [];
firstRun2 = [];
size = 5;
deg_stack1 = [];
deg_stack2 = [];
filtered_deg_stack1 = [];
filtered_deg_stack2 = [];

%% Index finger modeling(calibration)
global time_stack data_stack
f = 440; d = 1; fs = 44100; n = d*fs;
t = (1:n)/fs; y = sin(2*pi*f*t);
sound(y, fs)
disp('Calibration start')
disp('손을 펴세요')

pause(2);

startForeground(mydaq);
buffer.Open= data_stack;
open_data = [mean(data_stack(:,1)) mean(data_stack(:,2))];
sound(y, fs)
disp('주먹을 쥐세요')

pause(2);

startForeground(mydaq);
data_stack = data_stack(501:1000,:);
buffer.Close = data_stack;
close_data = [mean(data_stack(:,1)) mean(data_stack(:,2))];

sound(y, fs)
disp('Calibration finish')

%% Index finger modeling(callback)
mydaq.ScansAvailableFcn = @One_finger;
start(mydaq, "Duration", seconds(20)); % "Continuous" // "Duration", seconds(10)

%%
stop(mydaq)

