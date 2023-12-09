function listener_callback_week5_p2(src,event)
    global data_stack time_stack medVol medAngVel

    N = 5;                                              %Filter 차수
    Coeff1 = 50.4005105991401;	%Curve fit P1 계수
    Coeff2 = -130.389997882329; %Curve fit P2 계수
    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
        for i=1:N-1
            medVol(i,1)= event.Data(i,1);
        end
        for i=N:length(event.Data)
           medVol(i,1)= median(event.Data((i-N+1):i,1));
        end
    else
        temp = data_stack(length(data_stack)-N+2:length(data_stack),1);
        data_stack = [data_stack; event.Data];          %Voltage
        time_stack = [time_stack; event.TimeStamps];    %Time
        for i= 1:N-1
            tempMed=[temp(i:length(temp),1);event.Data(1:i,1)];
            temp_med(i,1)= median(tempMed);
        end
        for i = N:length(event.Data)
            temp_med(i,1) = median(event.Data(i-4:i,1));
        end
        medVol=[medVol; temp_med];
    end
    plot(time_stack,medVol);
end