%This function is to call back the data stack from week2 assignment 1st problem

function listener_callback_week2_p2(src,event)
    global data_stack time_stack

    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
    else
        data_stack = [data_stack; event.Data]; %Voltage
        time_stack = [time_stack; event.TimeStamps]; %Time
    end
end