%This is to plot Voltage & Resistance graph in real time
function listener_callback_week2_pp(src,event)
    global data_stack time_stack

    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
    else
        data_stack = [data_stack; event.Data]; %Voltage
        time_stack = [time_stack; event.TimeStamps]; %Time
    end
%=====================================2-1)=====================================%   
    
    plot(time_stack,data_stack); grid on;   %x-axis = Time, y-axis = Voltage 
    title('Voltage graph in real time');       
    xlabel('Time [s]');                     
    ylabel('Voltage [V]');
    xlim([0 20]);                           %Time range from 0 to 20 seconds 
    ylim([0 7]);
    drawnow;                               %This is to plot in real time
    f1=figure(1);       
    movegui(f1,'northeast')                %Moving figure 1 to northeast of GUI to look 2 graphs simultaneously

    
%=====================================2-2)=====================================%
    figure(2);
    Rtotal=10*10^3;                        %Total resistance of variable resistor
    Vin= 5;                                %Assuming the input voltage is a 5* unit step
    resistance= data_stack*Rtotal/Vin;     %R1 resistance calculation using potential divider equation
    plot(time_stack,resistance); grid on;   
    title('Resistance graph in real time');
    xlabel('Time [s]');
    ylabel('Resistance [Ω]');
    xlim([0 20]);
    ylim([-20 15000]);
    drawnow;
    f2=figure(2);
    movegui(f2,'northwest');

end