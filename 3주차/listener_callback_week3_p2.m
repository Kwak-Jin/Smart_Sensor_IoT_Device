function listener_callback_week3_p2(src,event)
    global data_stack time_stack flag angle angMAF N
    N=5;                                                    %Filter Size is smaller than length(event.Data)
    Coefficient= [-45.7150440068524 109.957148575755];      %LSM Coeff
    if isempty(data_stack)
        flag = 0;
        data_stack = event.Data;
        time_stack = event.TimeStamps;
        angle = Coefficient(1,1) * event.Data + Coefficient(1,2);
        %Moving average filter about angle
        MAF();
        flag = 1;
    else
        data_stack = [data_stack; event.Data]; %Voltage
        time_stack = [time_stack; event.TimeStamps]; %Time
        %Angle data is already updated
        angle = [angle ; Coefficient(1,1)*event.Data+Coefficient(1,2)];
        MAF();
    end
 
%=======================================================2-1======================================================%
    figure(1);
    plot(time_stack, angle); grid on;                              %real time plotting
    drawnow
    fig1= figure(1);
    movegui(fig1,'north');
%=======================================================2-2======================================================%
    figure(2);
    plot(time_stack, angMAF); grid on;                              %real time plotting
    drawnow
    fig2= figure(2);
    movegui(fig2,'south');
end 