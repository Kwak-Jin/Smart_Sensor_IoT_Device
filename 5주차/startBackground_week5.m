% startBackground
clear all; close all; clc;
global data_stack time_stack medVol medAngVel

mydaq= daq.createSession('ni');
mydaq.Rate= 1000;
mydaq.DurationInSeconds=10.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';   

lh = addlistener(mydaq,'DataAvailable', @listener_callback_week5_p2);

startBackground(mydaq);