%===============Smart Sensors and IoT device ===============%
%===============    Flex Sensor calibration  ===============%
% Author    : Jin Kwak     %
% Created   : 2023.06.01   %
% Modified  : 2023.06.01   %
function listener_callback_final(src,event)
    global data_stack time_stack

    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
    else
        data_stack = [data_stack; event.Data]; %Voltage
        time_stack = [time_stack; event.TimeStamps]; %Time
    end
end