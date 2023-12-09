function Neuron_Beat_example(obj, evt)
    global data_stack time_stack trigger_stack my_arduino
    
    [data_buff, timeStamp_buff, triggernTime_buff] = read(obj, obj.ScansAvailableFcnCount, "OutputFormat", "Matrix");
    if isempty(data_stack)
        data_stack = data_buff;
        time_stack = timeStamp_buff;
        trigger_stack = triggernTime_buff;
        
        my_arduino = serial("COM5");
        fopen(my_arduino)
        set(my_arduino, 'BaudRate', 9600);
        set(my_arduino, 'terminator', char(37));
        
    else
        data_stack = [data_stack; data_buff];
        time_stack = [time_stack; timeStamp_buff];
        trigger_stack = [trigger_stack; triggernTime_buff];
    end
    
    figure(1)
    plot(time_stack, data_stack(:,1));
    drawnow
    
    fprintf(my_arduino, '%d', 1);
    pause(0.05);
    P_color = [1 0.1 0.1];
    figure(2)
    plot(time_stack, data_stack(:,2), 'Color', P_color)
    drawnow
end

