function avg = MovingAvgFilter(x,n)
    global first_Run
    persistent prevAvg k %local global.. �� �Լ� ������ ����� �ٸ� �Լ����� ��밡��
    if isempty(first_Run)
        X=[x];
        k = 1;
        prevAvg = 0;
        first_Run = 1;
   
    elseif k<n
        X=[X ; x];
        avg= (prevAvg*(k-1)+x)/k;
    end
    
    avg = prevAvg + (x- )
    

    prevAvg = avg;
    
    k = k+1;
end

