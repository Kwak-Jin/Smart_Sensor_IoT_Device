% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function ShowLapTime(TYPE_TRACK)
    global Fig TIME_LAP;
    TextLap = sprintf('Lap Time : %.3f[sec]',TIME_LAP);
    fprintf('Track %c %s\n\n',TYPE_TRACK,TextLap);
    
    Fig;
    switch TYPE_TRACK
        case 'A'
            text(8, 0.8, TextLap,'FontSize',12)
        case 'B'
            text(5, 11.5, TextLap,'FontSize',12)
        case 'C'
            text(15, -10, TextLap,'FontSize',12)
        case 'D'
            text(9, -12, TextLap,'FontSize',12)
        case 'E'
            text(-18, -8, TextLap,'FontSize',12)
        otherwise
            %
    end
end