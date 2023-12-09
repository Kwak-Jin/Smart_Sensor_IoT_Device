clear all; close all; clc;
global data_stack time_stack re_data_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;
mydaq.DurationInSeconds=20.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';   

lh = addlistener(mydaq,'DataAvailable', @listener_callback_week2_pp);

startBackground(mydaq);
file= "savefile.mat";
save("savefile","data_stack");

%%
stop(mydaq);
%%
instrreset; clear all; close all; clc;
