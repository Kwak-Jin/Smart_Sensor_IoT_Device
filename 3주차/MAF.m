global data_stack time_stack flag angle angMAF N
if flag == 0
    %isempty status
    for i = 1:N-1
        %Before window size
        angMAF(i,1) = angle(i,1); 
    end
    %First Mean
    angMAF(N,1) = sum(angle(1:N,1))/N;
    for i = N+1:length(event.Data)
        %Recursive expression
        angMAF(i,1) =angMAF(i-1,1) +(angle(i)-angle(i-N))/N; 
        %temporary angle is updated
    end
else
    for i= length(angle)-length(event.Data)+1: length(angle)
        angMAF(i,1)= angMAF(i-1,1) +(angle(i)-angle(i-N))/N;
    end
end