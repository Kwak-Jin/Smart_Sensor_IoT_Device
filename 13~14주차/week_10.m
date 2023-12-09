%% Week 10
delete(instrfindall); clear all; close all; clc;

global data_stack time_stack trigger_stack

mydaq = daq('ni');
sampleRate = 1000;
ts = 1/sampleRate;

mydaq.Rate = sampleRate;

ch1 = addinput(mydaq, 'Dev2', 'ai0', 'Voltage');
ch2 = addinput(mydaq, 'Dev2', 'ai1', 'Voltage');

ch1.Range = [-5 5];
ch2.Range = [-5 5];
ch1.TerminalConfig = 'SingleEnded';
ch2.TerminalConfig = 'SingleEnded';

mydaq.ScansAvailableFcn = @Neuron_Beat_example;

start(mydaq, "Duration",seconds(30)); % "Continuous" , "Duration", seconds(10)

%%
stop(mydaq);
%%
