% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function CheckDriveFinish(X_car, Y_car, Line)
    global mydaq TYPE_TRACK TIME_LAP;
    
    cnt = 0;
    switch TYPE_TRACK
        case 'A'
            for i = 1:length(X_car)
                if X_car(i) > Line(1,1)
                    cnt = cnt+1;
                end
            end
        case 'B'
            for i = 1:length(X_car)
                if X_car(i) > Line(1,1)
                    cnt = cnt+1;
                end
            end
        case 'C'
            for i = 1:length(Y_car)
                if Y_car(i) < Line(1,2)
                    cnt = cnt+1;
                end
            end
        case 'D'
            for i = 1:length(X_car)
                if Y_car(i) < Line(1,2)
                    cnt = cnt+1;
                end
            end
        case 'E'
            for i = 1:length(X_car)
                if Y_car(i) < Line(1,2) && X_car(i) < Line(1,1)
                    cnt = cnt+1;
                end
            end
        otherwise
            
    end
    
    if cnt == length(X_car)
        TIME_LAP = toc;
        FinishCarModel(mydaq,TYPE_TRACK);
    end
            
end