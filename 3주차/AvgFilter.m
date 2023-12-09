function avg = AvgFilter(x)
    global first_Run
    persistent prevAvg k %local global.. 이 함수 내에서 선언된 다른 함수에서 사용가능
    
    if isempty(first_Run)
        k = 1;
        prevAvg = 0;
        first_Run = 1;
    end
    
    alpha = (k-1)/k;
    
    avg = alpha*prevAvg + (1-alpha)*x;
    
    prevAvg = avg;
    k = k+1;
end

