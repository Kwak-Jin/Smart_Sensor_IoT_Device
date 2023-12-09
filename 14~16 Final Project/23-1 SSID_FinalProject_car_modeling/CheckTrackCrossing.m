function [SttVec, X_car, Y_car, FLAG_CROSS] = CheckTrackCrossing(SttVec, X_car, Y_car)
    % SttVec = [ v_p_k; pi_p_k; x_p_k; y_p_k ];
    persistent TrackInfo l ri ro xc yc N_car;
    persistent prev_SttVec prev_Xcar prev_Ycar;
    global FLAG_SETUP TYPE_TRACK;
    
    % Import Track Info
    if(FLAG_SETUP == 0)
        TrackFile = load(sprintf('TrackData_Track%c.mat',TYPE_TRACK));
        TrackInfo = TrackFile.TrackData;
        clear TrackFile;
        
        l = 0.4;        % 0.4[m] = 40[cm] : length of the car
        ri = 5.0;     ro = 6.5;
        xc = 5.75;    yc = 7;
        
        N_car = length(X_car);
        prev_SttVec = zeros(1,length(SttVec));
        prev_Xcar = zeros(1,length(X_car)); 
        prev_Ycar = zeros(1,length(Y_car));
        FLAG_SETUP = 1;
    end
    
    FLAG_CROSS = 0;
    switch TYPE_TRACK
        % ----------------------------------------------------------------------------
        case 'A'
            if SttVec(4) <= (TrackInfo(1,2)+l/2)
                FLAG_CROSS = 1;
            elseif SttVec(4) > TrackInfo(1,2) && SttVec(4) < TrackInfo(2,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(2,1) || X_car(i) < TrackInfo(40,1)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(4) >= TrackInfo(2,2) && SttVec(3) < TrackInfo(19,1)
                for i = 1:N_car
                    R_car = sqrt((X_car(i) - xc)^2 + (Y_car(i) - yc)^2);
                    if R_car < ri || R_car > ro
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) >= TrackInfo(19,1) && SttVec(3) < TrackInfo(20,1)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(21,2) || Y_car(i) < TrackInfo(20,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            end
        % ----------------------------------------------------------------------------    
        case 'B'
            if SttVec(3) <= (TrackInfo(1,1)+l/2)
                FLAG_CROSS = 1;
            elseif SttVec(3) > (TrackInfo(1,1)+l/2) && SttVec(3) <= TrackInfo(11,1) && SttVec(4) < TrackInfo(11,2)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(11,2) || Y_car(i) < TrackInfo(2,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) > TrackInfo(11,1) && SttVec(4) <= TrackInfo(11,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(2,1) || Y_car(i) < TrackInfo(2,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(4) > TrackInfo(2,2) && SttVec(4) <= TrackInfo(10,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(2,1) || X_car(i) < TrackInfo(10,1)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) >= TrackInfo(10,1) && SttVec(4) > TrackInfo(10,2) && SttVec(4) < TrackInfo(3,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(3,1) || Y_car(i) > TrackInfo(3,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) >= TrackInfo(4,1) && SttVec(3) < TrackInfo(10,1) && SttVec(4) < TrackInfo(3,2)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(4,2) || Y_car(i) < TrackInfo(10,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) < TrackInfo(4,1) && SttVec(4) <= TrackInfo(4,2)
                for i = 1:N_car
                    if X_car(i) < TrackInfo(9,1) || Y_car(i) < TrackInfo(9,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(4) > TrackInfo(9,2) && SttVec(4) <= TrackInfo(5,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(5,1) || X_car(i) < TrackInfo(9,1)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) < TrackInfo(5,1) && SttVec(4) > TrackInfo(5,2)
                for i = 1:N_car
                    if X_car(i) < TrackInfo(8,1) || Y_car(i) > TrackInfo(8,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) >= TrackInfo(8,1) && SttVec(3) < TrackInfo(7,1)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(8,2) || Y_car(i) < TrackInfo(5,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            end
        % ----------------------------------------------------------------------------
        case 'C'
            if SttVec(3) <= (TrackInfo(1,1)+l/2)
                FLAG_CROSS = 1;
            elseif SttVec(3) > (TrackInfo(1,1)+l/2) && SttVec(3) <= TrackInfo(2,1)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(8,2) || Y_car(i) < TrackInfo(2,2)
                        FLAG_CROSS = 1; fprintf('1'); break;
                    end
                end
            elseif SttVec(3) > TrackInfo(2,1) && SttVec(3) <= TrackInfo(5,1) && SttVec(4) >= TrackInfo(2,2)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(8,2)
                        FLAG_CROSS = 1; fprintf('2'); break;
                    end
                end
            elseif SttVec(3) > TrackInfo(5,1) && SttVec(3) <= TrackInfo(6,1)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(7,2) || Y_car(i) < TrackInfo(6,2) || X_car(i) > TrackInfo(6,1)
                        FLAG_CROSS = 1; fprintf('3'); break;
                    end
                end
            elseif SttVec(3) > TrackInfo(2,1) && SttVec(3) <= TrackInfo(5,1) && SttVec(4) < TrackInfo(2,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(5,1) || X_car(i) < TrackInfo(2,1)
                        FLAG_CROSS = 1; fprintf('4'); break;
                    end
                end
            end
        % ----------------------------------------------------------------------------
        case 'D'
            if SttVec(3) <= (TrackInfo(1,1)+l/2)
                FLAG_CROSS = 1;
            elseif SttVec(4) > TrackInfo(1,2) && SttVec(3) > (TrackInfo(1,1)+l/2) && SttVec(3) <= TrackInfo(2,1)
                for i = 1:N_car
                    if Y_car(i) > TrackInfo(42,2) || Y_car(i) < TrackInfo(1,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(3) > TrackInfo(2,1) && SttVec(4) >= TrackInfo(2,2)
                for i = 1:N_car
                    if X_car(i) > TrackInfo(41,1) || Y_car(i) > TrackInfo(41,2)
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(4) < TrackInfo(1,2) && SttVec(4) >= TrackInfo(20,2) && SttVec(3) < TrackInfo(40,1)
                for i = 1:N_car
                    R_car = sqrt((X_car(i) - 14.5178)^2 + (Y_car(i) - (-9.2500))^2);
                    if R_car < 8.5 || R_car > 10
                        FLAG_CROSS = 1; break;
                    end
                end
            elseif SttVec(4) < TrackInfo(20,2) && SttVec(4) >= TrackInfo(21,2)
                for i = 1:N_car
                    if X_car(i) < TrackInfo(20,1) || X_car(i) > TrackInfo(23,1)
                        FLAG_CROSS = 1; break;
                    end
                end
            end
        % ----------------------------------------------------------------------------
        case 'E'
            if SttVec(4) >= (TrackInfo(1,2)-l/2) && SttVec(3) > TrackInfo(124,1)
                FLAG_CROSS = 1;
            elseif SttVec(4) < (TrackInfo(1,2)-l/2) && SttVec(4) >= TrackInfo(2,2) && SttVec(3) > TrackInfo(123,1)
                for i = 1:N_car
                    if X_car(i) < TrackInfo(123,1) || X_car(i) > TrackInfo(2,1)
                        FLAG_CROSS = 1; fprintf('1'); break;
                    end
                end
            elseif SttVec(4) <= TrackInfo(2,2) && SttVec(3) > TrackInfo(31,1)
                for i = 1:N_car
                    R_car = sqrt((X_car(i) - (-5.2500))^2 + (Y_car(i) - (-3.2500))^2);
                    if R_car > 6 || R_car < 4.5
                        FLAG_CROSS = 1; fprintf('2'); break;
                    end
                end
            elseif SttVec(4) >= TrackInfo(93,2) && SttVec(3) < TrackInfo(93,1)
                for i = 1:N_car
                    R_car = sqrt((X_car(i) - (-15.7500))^2 + (Y_car(i) - (-3.2500))^2);
                    if R_car > 6 || R_car < 4.5
                        FLAG_CROSS = 1; fprintf('3'); break;
                    end
                end
            elseif SttVec(4) < TrackInfo(61,2) && SttVec(3) < TrackInfo(61,1)
                for i = 1:N_car
                    if X_car(i) < TrackInfo(63,1) || X_car(i) > TrackInfo(62,1)
                        FLAG_CROSS = 1; fprintf('4'); break;
                    end
                end
            end
            
        otherwise
            % 
    end
    
    if(FLAG_CROSS == 1)
        SttVec = prev_SttVec; 
        X_car = prev_Xcar; 
        Y_car = prev_Ycar;
    end
    prev_SttVec = SttVec; 
    prev_Xcar = X_car; 
    prev_Ycar = Y_car; 
end