% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function StartCarModel(NAME_DAQ, TrackType)
    global TYPE_TRACK FLAG_START FLAG_SETUP; 
    global FLAG_TIMER TIME_LAP;
    
    TYPE_TRACK = TrackType;   FLAG_START = 0;   
    FLAG_SETUP = 0;           FLAG_TIMER = 0;
    TIME_LAP = 0;
    
    close all;
    startBackground(NAME_DAQ);
    fprintf('Track %c Start\n\n', TYPE_TRACK);
end