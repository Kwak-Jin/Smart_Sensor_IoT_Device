function listener_callback_week4_p1(src,event)
    global data_stack time_stack angle_stack
    
    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
    else
        data_stack = [data_stack; event.Data]; %Voltage
        time_stack = [time_stack; event.TimeStamps]; %Time
    end
%=============================================1-3)=============================================%
    k= zeros(length(event.Data),1);
    if length(data_stack) == length(event.Data)
        for i= 2:length(event.Data)
            if event.Data(i-1,1)<=1.5 && 1.5 < event.Data(i,1) 
                k(i,1)= k(i-1,1) + 1; %시계방향
            else
                k(i,1)= k(i-1,1);     %아닐 시 k는 그 전값과 동일한 값을 가짐
            end
        end
        angle_stack= k * 15;          %k에 15배(각도)
    else
        if data_stack(length(data_stack)-length(event.Data),1) <=1.5 && 1.5 < event.Data(1,1)
            k(1,1) = 1;              %시계방향     마지막 data_stack 값과 event.Data의 첫 값을 비교
        end
        for i= 2:length(event.Data)
            if event.Data(i-1,1)<=1.5 && 1.5 < event.Data(i,1)
                k(i,1)= k(i-1,1) + 1; %시계방향
            else
                k(i,1)= k(i-1,1);     %현위치
            end
        end
        angle_buffer = ones(length(event.Data),1) * angle_stack(length(angle_stack),1); %angle_stack의 마지막 값이 들어간 event.Data크기만큼의 배열
        angle_stack = [angle_stack; angle_buffer + k * 15];                             %angle_stack 업데이트
    end
  %  plot(time_stack,angle_stack); hold on;grid on;
    plot(time_stack, data_stack); 
    title('Angle derived from Pulse');
    xlabel('Time [sec]');
  %  ylabel('Angle in real time [degree] and A channel signal [V]');
end