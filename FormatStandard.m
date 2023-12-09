%%
% startForeground

%표준 startForeground
%앞으로 copy해서 쓰기

instrreset; clear all; close all; clc;

global data_stack time_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 1000;                                   
mydaq.DurationInSeconds=20.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';

lh= addlistener(mydaq,'DataAvailable', @listener_callback_week2_p2); %바꾸셈
startForeground(mydaq);


%% 
% startBackground
clear all; close all; clc;
global data_stack time_stack re_data_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;
mydaq.DurationInSeconds=20.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';   

lh = addlistener(mydaq,'DataAvailable', @listener_callback_week2_pp); %바꾸셈

startBackground(mydaq);
%%
stop(mydaq);
%%
instrreset; clear all; close all; clc;

%%
function listener_callback_week2_p2(src,event)
    global data_stack time_stack

    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
    else
        data_stack = [data_stack; event.Data]; %Voltage
        time_stack = [time_stack; event.TimeStamps]; %Time
    end
end