global data_stack A_angle_stack
  if flag == 0
    for i=2:length(event.Data)
        Ay= AyCoeff(1,1)*data_stack(i,2)+AyCoeff(1,2);
        Ax= AxCoeff(1,1)*data_stack(i,3)+AxCoeff(1,2);
        A_angle_stack(i,1) = atan2(Ay,Ax) * 180/pi;
    end
  else
    for i = length(data_stack)-length(event.Data) +1:length(data_stack)
        Ay = AyCoeff(1,1)*data_stack(i,2)+AyCoeff(1,2);
        Ax = AxCoeff(1,1)*data_stack(i,3)+AxCoeff(1,2);
        A_angle_stack(i,1) = atan2(Ay,Ax) * 180/pi;
    end
  end    