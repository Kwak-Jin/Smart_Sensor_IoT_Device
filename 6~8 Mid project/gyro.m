global data_stack G_angle_stack G_angledot_stack
  G_angledot_stack(1,1)= (data_stack(1,1)-gyrobias)*2000;
  G_angle_stack(1,1)=0;
  %Numerical integration using trapezoidal integration
  if flag==0
    for i = 2:length(event.Data)
        dV = data_stack(i,1)-gyrobias;
        G_angledot_stack(i,1) = dV*2000;                                       %Angular velocity
        G_angle_stack(i,1) = G_angle_stack(i-1,1)+(G_angledot_stack(i-1,1)+G_angledot_stack(i,1))/2 *0.01;  %Numerical integration
    end
  else
    for i = length(data_stack)-length(event.Data) +1:length(data_stack)
        dV = data_stack(i,1)-gyrobias;
        G_angledot_stack(i,1) = dV*2000;                                       %Angular velocity
        G_angle_stack(i,1) = G_angle_stack(i-1,1)+(G_angledot_stack(i-1,1)+G_angledot_stack(i,1))/2 *0.01;  %Numerical integration   
    end  
  end