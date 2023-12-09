global data_stack G_angle_stack A_angle_stack CF_angle_stack 
%dt= 1/mydaq.Rate
%T: Time constant which we need to calculate mathematically
dt=1/ 100; %Sampling time
T= 0.6; %Time Constant Tau

CF_angle_stack(1,1)=0;
  if flag==0
    for i=2:length(event.Data)
        CF_angle_stack(i,1)= T/(T+dt) * CF_angle_stack(i-1,1) +dt/(T+dt) * A_angle_stack(i,1) + T/(T+dt) * (G_angle_stack(i,1)-G_angle_stack(i-1,1));   
    end
  else
    for i= (length(data_stack)-length(event.Data) +1):length(data_stack)
        CF_angle_stack(i,1)= T/(T+dt) * CF_angle_stack(i-1,1) +dt/(T+dt) * A_angle_stack(i,1) + T/(T+dt) * (G_angle_stack(i,1)-G_angle_stack(i-1,1));
    end
  end