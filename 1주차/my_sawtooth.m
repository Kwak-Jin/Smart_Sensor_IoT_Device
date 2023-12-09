function my_sawtooth(period,peak,t)
    y=peak/period*rem(t,(period)); %y값에 t에 진폭/주기를 나눈 나머지 값을 넣어준다.
    plot(t,y);
    xlabel('Time[sec]'); ylabel('Signal'); %x축과 y축 라벨링
    title(['Saw-tooth Signal:period of ',num2str(period),' sec'] ); %plot창의 제목
    len=length(t); %t의 길이
    xmin=t(1); xmax=t(len); %x축의 최소값, 최대값 지정
    ymin=0; ymax=peak+1; %y축의 최소값, 최대값 지정 (가시성을 위해 +1 하였음)
    axis([xmin xmax ymin ymax]); %축의 범위 지정
end