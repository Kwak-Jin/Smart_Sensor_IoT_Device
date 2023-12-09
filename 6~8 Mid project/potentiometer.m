global data_stack P_angle_stack
  if flag==0
    for i=1:length(event.Data)
        P_angle_stack(i,1)= Coeff_potentiometer(1,1)*data_stack(i,4) + Coeff_potentiometer(1,2);
    end
  else
    for i= length(data_stack)-length(event.Data) +1:length(data_stack)
        P_angle_stack(i,1)= Coeff_potentiometer(1,1)*data_stack(i,4) + Coeff_potentiometer(1,2);    
    end
  end