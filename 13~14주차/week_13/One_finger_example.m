function One_finger_example(obj, evt)
    global data_stack time_stack trigger_stack open_data close_data deg_stack filtered_deg_stack size
    
    [data_buff, timeStamp_buff, triggernTime_buff] = read(obj, obj.ScansAvailableFcnCount, "OutputFormat", "Matrix");
    if isempty(data_stack)
        data_stack = data_buff;
        time_stack = timeStamp_buff;
        trigger_stack = triggernTime_buff;
        
    else
        data_stack = [data_stack; data_buff];
        time_stack = [time_stack; timeStamp_buff];
        trigger_stack = [trigger_stack; triggernTime_buff];
    end
    
    % DAQ로 받은 전압값(data_stack)을 각도값(PIP)으로 바꿔주세요.
    
    T0 = Rot(0) * Trans(1.5, 0);
    T1 = Rot(MCP에 관한 식) * Trans(1,0);
    T2 = Rot(PIP에 관한 식) * Trans(1,0);
    T3 = Rot(DIP에 관한 식) * Trans(1,0);

    Tn = plotArm(T0, T1, T2, T3);

end

function R = Rot(theta)
    c = cosd(theta);
    s = sind(theta);
    R = [c -s 0; s c 0; 0 0 1];
end

function P = Trans(x, y)
    P = [1 0 x; 0 1 y; 0 0 1];
end

function T = plotArm(varargin)
    n = length(varargin) + 1;
    T = zeros(3, 3, n);
    T(:, :, 1) = eye(3);
    
    for i = 2:n
        T(:, :, i) = T(:, :, i-1) * cell2mat(varargin(i-1));
    end
    
    x = squeeze(T(1, end, :));
    y = squeeze(T(2, end, :));
    
    for i = 1:length(x)-1
        plot(x(i:i+1), y(i:i+1), 'LineWidth', 5);
        hold on
    end
    
    xlim([-2 5])
    ylim([-4 2])
    drawnow
    hold off
    
    xlabel('x'); ylabel('y'); title('Index Finger');
end