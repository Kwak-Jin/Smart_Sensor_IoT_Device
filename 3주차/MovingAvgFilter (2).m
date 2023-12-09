function avg = MovingAvgFilter(x,n)
    global first_Run
    persistent prevAvg k %local global.. 이 함수 내에서 선언된 다른 함수에서 사용가능
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

