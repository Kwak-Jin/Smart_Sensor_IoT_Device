% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
% ===========================Jin Kwak changed on 2023/06/05=========================== %
function RunCarModel(src,event)
    global V_L V_R plot_var mean_R mean_L
    
    V_L= mean(event.Data(:,1));         %Left Voltage is mean of 50 data set                       
    V_R= mean(event.Data(:,2));
    [w_L, w_R] = CmdCarModel(V_L,V_R);  %Right, Left Voltage is put in the CmdCarModel function and the angular velocity of wheels of left/right vehicle is obtained
    PlotCarModel(w_L,w_R);              %Movement of Vehicle is only dependent on the wheels' angular velocity
        