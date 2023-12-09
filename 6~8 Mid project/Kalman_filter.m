global data_stack G_angledot_stack G_angle_stack A_angle_stack KF_angle_stack Theta_ Theta_p P_k P_p K
    if flag == 0
        Theta_= zeros(2,1);
        P_p= A * 100 *A' + Q;
        Theta_p = zeros(2,1);
       for i = 2: length(event.Data)    
          %Priori (Predictor)
          Theta_ = A * [Theta_p(1,1) ; G_angledot_stack(i,1)];
          P_k = A * P_p* A' + Q;

          %Posterior (Corrector)
          K = P_k * H' * inv(H * P_k * H' + R);
          Theta_p = Theta_ + K*(A_angle_stack(i,1) -H * Theta_);
          P_p = (eye(2) - K * H) * P_k * (eye(2)- K* H)' + K * R * K';
          KF_angle_stack(i,1) = Theta_p(1,1);          
       end
    else
        for i = length(data_stack)-length(event.Data)+1: length(data_stack)    
          %Priori (Predictor)
          Theta_ = A * [Theta_p(1,1) ; G_angledot_stack(i,1)];
          P_k = A * P_p* A' + Q;

          %Posterior (Corrector)
          K = P_k * H' * inv(H * P_k * H' + R);
          Theta_p = Theta_ + K*(A_angle_stack(i,1) -H * Theta_);
          P_p = (eye(2) - K * H) * P_k * (eye(2)- K* H)' + K * R * K';
          KF_angle_stack(i,1) = Theta_p(1,1);          
        end
    end
