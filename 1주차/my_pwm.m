function my_pwm(dutyratio,frequency,t)
    T = 1/frequency; %주기 계산
    len=length(t); %t 배열 크기
    y= zeros(1,len); %빈 행렬 생성
    for i=1:len
        if rem(t(i),T) <=(dutyratio*T) %나머지의 비율이 주기의 duty ratio 보다 작을 시에 1을 반환하는 조건문
            y(i)=1;
        else
            y(i)=0;
        end
    end
    ymin=-0.1; ymax=1.2; 
    xmin=t(1); xmax= t(len);
    plot(t,y);
    dutyptg= dutyratio*100; %duty ratio를 퍼센트 단위로 변환
    xlabel('Time [sec]'); ylabel('Signal');
    title(['Pulse Width modulation: duty ratio ',num2str(dutyptg),'% ',num2str(frequency),'Hz']);
    axis([xmin xmax ymin ymax]);
end