% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function CheckDriveStart(X_car, Y_car, Line)
    global TYPE_TRACK FLAG_TIMER;
    
    flag = 0;
    switch TYPE_TRACK
        case 'A'
            for i = 1:length(X_car)
                if Y_car(i) > Line(1,2)
                    flag = 1; break;
                end
            end
        case 'B'
            for i = 1:length(X_car)
                if X_car(i) > Line(1,1)
                    flag = 1; break;
                end
            end
        case 'C'
            for i = 1:length(X_car)
                if X_car(i) > Line(1,1)
                    flag = 1; break;
                end
            end
        case 'D'
            for i = 1:length(X_car)
                if X_car(i) > Line(1,1)
                    flag = 1; break;
                end
            end
        case 'E'
            for i = 1:length(Y_car)
                if Y_car(i) < Line(1,2)
                    flag = 1; break;
                end
            end
        otherwise
            
    end

    if(flag==1) 
        tic;
        FLAG_TIMER = 1;
    end
end