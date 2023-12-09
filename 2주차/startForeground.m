clear all; close all; clc;

global data_stack time_stack

mydaq= daq.createSession('ni');
mydaq.Rate= 100;                                        %3번 문제 조건에 따라 바꿀 필요 있음
mydaq.DurationInSeconds=1.0;
mydaq.NotifyWhenDataAvailableExceeds = mydaq.Rate/20;

ch = addAnalogInputChannel(mydaq,'Dev2',0,'Voltage'); %mydaq, device number, pin number

ch(1).Range = [-10.0 10.0];
ch(1).TerminalConfig = 'SingleEnded';


lh= addlistener(mydaq,'DataAvailable', @listener_callback_week2_p2);
startForeground(mydaq);


% %===========================================1번================================================%
% %가변 저항의 총 저항은 10kOhm
% %Voltage divider식 Vout= Vin *(R1/(Rtotal))
% %R1=Vout*Rtotal/Vin
Vin=5;                                               %Input voltage
Rtot=10*10^3;                                        %R total
plot(time_stack,data_stack);                         %Visualize the data(voltage)
Vavg= sum(data_stack)/length(data_stack);            %Average voltage of 100 dataset
resistance= Vavg*Rtot/Vin;                           %Equation derived from voltage divider 

% %DMM으로 측정한 저항을 참 값으로 가정하고 다음을 설명하세요.
% %정확성(절대오차, 퍼센트오차)
% %정밀성(표준편차)
% %위의 정확성과 정밀성을 갖는 원인
% 
% Rs=[937.8004 2.3043e+03 5.5675e+03 6.9475e+03 9.8334e+03;  %1st trial
%     935.4024 2.3042e+03 5.5672e+03 6.9478e+03 9.8326e+03;  %2nd
%     938.4637 2.3042e+03 5.5762e+03 6.9475e+03 9.8332e+03;  %3rd
%     935.8616 2.3052e+03 5.5692e+03 6.9481e+03 9.8331e+03;  %4th
%     936.8310 2.3033e+03 5.5768e+03 6.9482e+03 9.8341e+03]; %5th
% 
% Rd=[0.92e+03; %DMM으로 측정한 0~1V 저항 참값
%     2.33e+03; %1~2V 전압일 때 저항 참값
%     5.58e+03;
%     6.91e+03;
%     9.71e+03];
% AbsEr1=sum(Rs(:,1))/5 -Rd(1,1);
% AbsEr2=sum(Rs(:,2))/5 -Rd(2,1);
% AbsEr3=sum(Rs(:,3))/5 -Rd(3,1);
% AbsEr4=sum(Rs(:,4))/5 -Rd(4,1);
% AbsEr5=sum(Rs(:,5))/5 -Rd(5,1);
% 
% 
% AbsoluteError=[AbsEr1;
%                AbsEr2;
%                AbsEr3;
%                AbsEr4;
%                AbsEr5];
% RelativeError=[AbsEr1/Rd(1,1)*100; %0~1V 상대오차
%                AbsEr2/Rd(2,1)*100;
%                AbsEr3/Rd(3,1)*100;
%                AbsEr4/Rd(4,1)*100;
%                AbsEr5/Rd(5,1)*100];
% StandardDeviation=[std(Rs(:,1)); %0~1V 표준편차
%                    std(Rs(:,2)); %1~2V 표준편차 
%                    std(Rs(:,3)); %2~3V 표준편차
%                    std(Rs(:,4)); %3~4V 표준편차
%                    std(Rs(:,5))];%4~5V 표준편차

%===========================3번================================%
%- 샘플링: 100 [Hz], 계측시간: 1.0 [s] => 데이터 100개
avg1x100= sum(data_stack)/length(data_stack);   %데이터 100개의 평균
std1x100= std(data_stack);                      %데이터 100개의 표준편차
%- 샘플링: 500 [Hz], 계측시간: 1.0 [s] => 데이터 500개
mean1x500= sum(data_stack)/length(data_stack);  %500개의 평균
std1x500=std(data_stack);                       %데이터500개의 표준편차


%- 샘플링: 500 [Hz], 계측시간: 1.0 [s] => 500개를 5개씩 묶어서 평균=> 데이터 100개
avg5x100=zeros(length(data_stack)/5,1);

for i=1:length(data_stack)/5
    sum5x100=0;
    for j=(i*5)-4:(i*5)
    sum5x100=sum5x100+ data_stack(j,1);
    end
    avg5x100(i,1)= sum5x100/5;
end
    mean5x100 = sum(avg5x100)/length(avg5x100);
    std5x100=std(avg5x100);                     %5개씩 묶은 데이터 100개의 평균의 표준편차


%- 샘플링: 1000 [Hz], 계측시간: 1.0 [s] => 1000개를 10개씩 묶어서 평균=>  데이터 100개

avg10x100=zeros(length(data_stack)/10,1);

for i=1:length(data_stack)/10
    sum10x100=0;
    for j=(i*10)-9:(i*10)
    sum10x100=sum10x100+ data_stack(j,1);
    end
    avg10x100(i,1)= sum10x100/10;                   %10개씩 묶은 데이터 100개
end
    std10x100=std(avg10x100);                       %10개 묶은 데이터100개의 표준 편차
    mean10x100 = sum(avg10x100)/length(avg10x100);  %1000개의 평균 

