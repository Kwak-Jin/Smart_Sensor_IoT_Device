% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function FinishCarModel(NAME_DAQ, TYPE_TRACK)
    stop(NAME_DAQ);
    fprintf('Track %c Finished\n\n', TYPE_TRACK);
    ShowLapTime(TYPE_TRACK);
end