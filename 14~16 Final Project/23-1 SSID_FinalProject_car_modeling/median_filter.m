global V_L V_R time_stack plot_var mean_R mean_L flag medR medL n
len= length(event.Data);
    if flag == 0
        for i=1:n-1
            medL(i,1) = event.Data(i,1);
            medR(i,1) = event.Data(i,2);
            [w_L, w_R] = CmdCarModel(medL(i,1), medR(i,1));
            PlotCarModel(w_L, w_R);            
        end
        for i=n:length(event.Data)
           medL(i,1)= median(event.Data((i-n+1):i,1));
           medR(i,1)= median(event.Data((i-n+1):i,2));
           [w_L, w_R] = CmdCarModel(medL(i,1), medR(i,1));
           PlotCarModel(w_L, w_R);            
        end
    else
        tempL = V_L(length(V_L)-len-n+2:length(V_L)-len,1);
        tempR = V_R(length(V_R)-len-n+2:length(V_R)-len,2);
        for i= 1:n-1
            temp_medL(i,1)= median(tempL);

            temp_medR(i,1)= median(tempR);
           
            tempL=[tempL(2:end,1); event.Data(i,1)];
            tempR=[tempR(2:end,1); event.Data(i,2)];
            [w_L, w_R] = CmdCarModel(temp_medL(i,1), temp_medR(i,1));
            PlotCarModel(w_L, w_R);                     
        end
        for i = n:len
            temp_medL(i,1) = median(event.Data(i-n+1:i,1));
            temp_medR(i,1) = median(event.Data(i-n+1:i,2));
           [w_L, w_R] = CmdCarModel(temp_medL(i,1), temp_medR(i,1));
            PlotCarModel(w_L, w_R);                     
        end
        medL= [medL; temp_medL];
        medR= [medR; temp_medR];
    end