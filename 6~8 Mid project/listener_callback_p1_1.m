function listener_callback_p1_1(src,event)
    global data_stack time_stack G_angle_stack G_angledot_stack A_angle_stack P_angle_stack CF_angle_stack  KF_angle_stack
    
    %Accelerometer Coefficient using Least Square method
    AxCoeff= [-5.03198383143487	10.1081256464420];
    AyCoeff= [5.20663428947808	-10.5484664475751];
    
    %Potentiometer Coefficient using Least Square method
    Coeff_potentiometer=[-69.5454591539502	185.885928748418]; %Derive from Polyfit potentiometervoltage and angle
    
    %Gyroscope bias
    gyrobias= 1.37852992325277;  %Gyrobias should always be measured before test around 1.37~1.38 at 0 degree/s
    
    %Kalman Filter Matrix
    dt= 0.01;
    A = [1 dt;
         0 1];
    H = [1 0];
    sig_process = 10;
    sig_gyro = 10;
    sig_acc = 100;   
    Q = [(sig_process)^2       0;
          0               (sig_gyro)^2];
    R = (sig_acc)^2;
    if isempty(data_stack)
        data_stack = event.Data;
        time_stack = event.TimeStamps;
        flag=0;
        gyro();
        accelerometer();
        potentiometer();
        complementaryfilter();
        Kalman_filter();
        flag= flag+1;
    else
        data_stack = [data_stack; event.Data];                %Voltage
        time_stack = [time_stack; event.TimeStamps];          %Time
        gyro();
        accelerometer();
        potentiometer();
        complementaryfilter();
        Kalman_filter();
    end
end