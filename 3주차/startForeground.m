clear all; close all; clc;
global data_stack time_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;                                   
mydaq.DurationInSeconds=1.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';

lh= addlistener(mydaq,'DataAvailable', @listener_callback_week3_p1); %바꾸셈
startForeground(mydaq);
%=======================================================1-1======================================================%

DATA =[-125 4.9850;     %1열이 각도 2열이 전압 전압이  x 각도가 y
       -100 4.8000;
       -75  4.2060;
       -50  3.5520;
       -25  2.8150;
        0   2.3080; 
        25  1.7150;
        50  1.1360;
        75  0.7030;
        100 0.1880;
        125 0.0500];

 ANGLE=DATA(:,1);        %Extract angle data from DATA
 V=DATA(:,2);            %Extract voltage data from DATA
 Coeff=polyfit(V,ANGLE,1); %cftool을 쓴 선형회귀 계수

 H= [V ones(11,1)];         %Least square method에 쓰일 H행렬
 HTH= H'*H;                 % H'H 행렬

LSMcoeff = inv(HTH)*H'*ANGLE;   %최소제곱법 선형회귀 분석

disp('Coefficient using cftool');
disp(Coeff);                    %Polyfit 함수(cftool과 동일)로 추출한 선형회귀 식 계수
disp('Coefficient using least square method');
disp(LSMcoeff');                %최소제곱법 공식으로 추출한 선형회귀 식 계수

%=======================================================1-2======================================================%

Vavg= sum(data_stack)/length(data_stack);   %Batch expression of V 
angle= Coeff(1,1)*Vavg+ Coeff(1,2); % 전압과 각도의 선형회귀식 
disp(angle); 

