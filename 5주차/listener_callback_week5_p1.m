function listener_callback_week5_p1(src,event)
    global data_stack time_stack angle_stack AVel_stack mAngVel
    
    Coeff1 = 50.4005105991401;	%Curve fit P1 계수
    Coeff2 = -130.389997882329; %Curve fit P2 계수
    N = 9;              %The filter size should not exceed the length of event.Data
    dt= 1/1000;
    if isempty(data_stack)
        data_stack = event.Data;                                            %Voltage
        time_stack = event.TimeStamps;
        angle_stack= Coeff1.* data_stack + Coeff2;                          %Angle
        AVel_stack=zeros(length(event.Data),1);                             %Angular Velocity
        for i=2:length(event.Data)
            AVel_stack(i,1)= (angle_stack(i,1)-angle_stack(i-1,1)) /dt;   %Angular Velocity
        end 
        if length(event.Data)<N
            for i=1:length(event.Data)
                mAngVel(i,1)= AVel_stack(i,1);
            end
        else
            for i=1:N-1                             
                mAngVel(i,1)= AVel_stack(i,1);                                  %Median Filtered Angular Velocity
            end 
        end
        for i=N:length(event.Data)
            temp=AVel_stack((i-N+1):i,1);                                   %Temporary Angular Velocity
            tempsort=sort(temp);                                            %Sorting angular velocity Array
            mAngVel(i,1)= tempsort(ceil(N/2));                              %Extracting Median
        end
    else
        data_stack = [data_stack; event.Data];                              %Voltage
        time_stack = [time_stack; event.TimeStamps];                        %Times
        angle_stack=  Coeff1.*data_stack +Coeff2;                           %Angle length(angle_stack)==length(data_stack)
        k=zeros(length(event.Data),1);                                      %Temporary Angular velocity
        k(1,1)= (Coeff1*event.Data(1,1)+Coeff2 - angle_stack(length(angle_stack)-length(event.Data),1))/dt;
        for i=2:length(event.Data)
            k(i,1)= (angle_stack(length(angle_stack) -length(event.Data) +i ,1)- angle_stack(length(angle_stack) -length(event.Data) +i-1 ,1)) /dt;
        end
        AVel_stack=[AVel_stack; k];                                         %Angular Velocity

        for i=length(AVel_stack)-length(event.Data)+1:length(AVel_stack)
            temp=(AVel_stack(i-N+1:i,1));                                   %Temporary Angular Velocity Array
            tempsort= sort(temp);                                           %Sorting Array
            mAngVel(i,1) = tempsort(ceil(N/2),1);                           %Extracting Median
        end
    end
%================================1-2================================%
%         plot(time_stack,angle_stack);
%         xlabel('Time [sec]');
%         ylabel('Angle [degree]');
%         title('Potentiometer degree');

%================================1-3================================%
% plot(time_stack,AVel_stack);
% xlabel('Time [sec]');
% ylabel('Angular Velocity [deg/s]');
% title('Angular velocity of Potentiometer (Unfiltered)');

%================================1-4================================%
        plot(time_stack, mAngVel);
        xlabel('Time [sec]');
        ylabel('Angular velocity [degree/s]');
        title('Filtered Angular velocity of potentiometer');
        
end