% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function [w_L w_R] = CmdCarModel(V_in_L, V_in_R)
    % Converting Input Signal(Sensor) to Command Signal(Car)
    % Binary decision
    global mean_R mean_L
    
    if  V_in_L > mean_L && V_in_R > mean_R                        % Both Open data
        w_L = -3; 
        w_R = -3;                                                 % Reverse

    elseif V_in_L > mean_L && V_in_R < mean_R                     % Left Open Right Close
        w_L = 1;
        w_R = 5;                                                  % Right turn
    elseif V_in_R > mean_R && V_in_L < mean_L                     % Right Open Left Close
        w_L = 5;                                                  % Left Turn
        w_R = 1;     
    else
        w_L = 8;                                                  % Both Close
        w_R = 8;                                                  % Go Straight 
    end
end