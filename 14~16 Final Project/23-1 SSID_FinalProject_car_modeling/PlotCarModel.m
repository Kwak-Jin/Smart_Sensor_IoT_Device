% ***** LAST DEVELOPER UPDATE : PWH 19.06.07  ***** %
function PlotCarModel(w_in_L, w_in_R)
    persistent r w l dt Track Line_S Line_F Line_R;
    persistent pi_p_k x_p_k y_p_k AxisLimit TextTitle;
    global FLAG_START FLAG_TIMER Rate_Plot TYPE_TRACK Fig;
    
    if(FLAG_START == 0)
    %-------------------- Setting ---------------------------------------
        % car info
        r = 0.2;        % 0.2[m] = 20[cm] : radius of both wheels
        w = 0.5;        % 0.5[m] = 50[cm] : width of the car
        l = 0.4;        % 0.4[m] = 40[cm] : length of the car

        % program info
        dt = 1/Rate_Plot;    % [sec]

    %-------------------- Calculation -----------------------------------
    % State Computation
        x_p0 = 0;               % initial position of x_p
        y_p0 = 0;               % initial position of y_p
        
        switch TYPE_TRACK       % initial steering angle of pi_p    %Initial attitude
            case 'A'
                pi_p0 = 0;
            case 'B'
                pi_p0 = pi/2;
            case 'C'
                pi_p0 = pi/2;
            case 'D'
                pi_p0 = pi/2;
            case 'E'
                pi_p0 = pi;
            otherwise
                pi_p0 = 0;
        end
        
        v_p_k = (w_in_L + w_in_R)*r/2;              % Average Velocity depends on the angular velocity of wheels 
        pi_p_k = (w_in_L - w_in_R)*r*dt/w + pi_p0;  % Turn rate(Clockwise) calculation 
        x_p_k = v_p_k*sin(pi_p_k)*dt + x_p0;        % x axis displacement update
        y_p_k = v_p_k*cos(pi_p_k)*dt + y_p0;        % y axis displacement update
        
        % Show Figure
        TrackFile = load(sprintf('TrackData_Track%c.mat',TYPE_TRACK));
        Track = TrackFile.TrackData;
        Line_S = TrackFile.LineData_Start;
        Line_F = TrackFile.LineData_Fin;
        if(TYPE_TRACK=='C'), Line_R = TrackFile.LineData_Ret; end
        Fig = figure('Name','Car Model','NumberTitle','off');
        set(Fig, 'OuterPosition', TrackFile.ValueOutPos);
        AxisLimit = TrackFile.ValueAxiLim;
        TextTitle = TrackFile.TextTitle;
        FLAG_START = 1;
    else
        v_p_k = (w_in_L + w_in_R)*r/2;                  % Average Velocity depends on the angular velocity of wheels
        pi_p_k = (w_in_L - w_in_R)*r*dt/w + pi_p_k;     % Turn(Clockwise) calculation
        x_p_k = v_p_k*sin(pi_p_k)*dt + x_p_k;           % x axis displacement update
        y_p_k = v_p_k*cos(pi_p_k)*dt + y_p_k;           % y axis displacement update
    end
    SttVec = [ v_p_k; pi_p_k; x_p_k; y_p_k ];           %State-vector [velocity, attitude, x-position, y-position]
    
    % Orientation Computation
    pi_Rot = 2*pi - pi_p_k;                                             
    RotMat = [ cos(pi_Rot) -sin(pi_Rot) ; sin(pi_Rot) cos(pi_Rot) ];    % Direction Cosine Matrix 
    OrtVec = [ w/2 ; l/2 ];                                             % half-width half-length vector
    X_fr = RotMat * [  1 0 ; 0  1 ] * OrtVec + [ x_p_k ; y_p_k ];       % Front Right calculation 
    X_fc = RotMat * [  0 0 ; 0  2 ] * OrtVec + [ x_p_k ; y_p_k ];       % Front Center calculation
    X_fl = RotMat * [ -1 0 ; 0  1 ] * OrtVec + [ x_p_k ; y_p_k ];       % Front Left calculation
    X_br = RotMat * [  1 0 ; 0 -1 ] * OrtVec + [ x_p_k ; y_p_k ];       % Back Right calculation
    X_bl = RotMat * [ -1 0 ; 0 -1 ] * OrtVec + [ x_p_k ; y_p_k ];       % Back Left calculation

    % Shape Assignment
    X_car = [ X_fr(1) X_fc(1) X_fl(1) X_bl(1) X_br(1)  X_fr(1) ];       
    Y_car = [ X_fr(2) X_fc(2) X_fl(2) X_bl(2) X_br(2)  X_fr(2) ];       
    
    %-------------------- Checking --------------------------------------
    % Line Crossing Detection
    [SttVec, X_car, Y_car, FLAG] = CheckTrackCrossing(SttVec, X_car, Y_car);
    pi_p_k = SttVec(2);  x_p_k = SttVec(3);  y_p_k = SttVec(4);
    
    %------------------- Plotting --------------------------------------
    plot(Track(:,1),Track(:,2),'k','linewidth',1.5);
    hold on;
    plot(Line_S(:,1),Line_S(:,2),'r','linewidth',1);
    plot(Line_F(:,1),Line_F(:,2),'b','linewidth',1);
    if(TYPE_TRACK=='C'), plot(Line_R(:,1),Line_R(:,2),'g--','linewidth',1); end
    plot(X_car, Y_car, 'r');
    title(TextTitle); axis(AxisLimit);
    hold off;
    drawnow 
    
    %-------------------- Checking --------------------------------------
    % Start & Finish Detection
    if(FLAG_TIMER==0), CheckDriveStart(X_car, Y_car, Line_S);
    else,              CheckDriveFinish(X_car, Y_car, Line_F); end

end