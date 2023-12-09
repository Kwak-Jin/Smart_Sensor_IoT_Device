global V_L V_R time_stack plot_var mean_R mean_L avgV_L avgV_R flag n
  if flag==0                               %If isempty(V_L)
    for i= 1 : n-1
        avgV_L(i,1) = event.Data(i,1);                        % filtered voltage before window size
        avgV_R(i,1) = event.Data(i,2);                            
        [w_L, w_R] = CmdCarModel(avgV_L(i,1), avgV_R(i,1));
        PlotCarModel(w_L, w_R);
    end
    for i= n : length(event.Data)
        avgV_L(i,1) = mean(V_L(i-n+1:i)) ;                     % After window size, average filter is adjusted with batch expression
        avgV_R(i,1) = mean(V_R(i-n+1:i)) ;                     
        [w_L, w_R] = CmdCarModel(avgV_L(i), avgV_R(i)) ;       % f(v) = angular velocity of Vehicle's left/right wheel
        PlotCarModel(w_L, w_R);                                % Unite each coordinate into Fixed frame and update vehicle position
    end

  else                                                      
      for i= length(V_L)-length(event.Data)+1:length(V_L) 
          avgV_L(i,1)= mean(V_L(i-n+1:i,1)) ;
          avgV_R(i,1)= mean(V_R(i-n+1:i,1)) ;
          [w_L, w_R] = CmdCarModel(avgV_L(i,1), avgV_R(i,1));
          PlotCarModel(w_L, w_R);            
      end
  end