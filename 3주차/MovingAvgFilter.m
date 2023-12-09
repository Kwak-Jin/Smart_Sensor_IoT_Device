function avg = MovingAvgFilter(x,n)
    global first_Run
    persistent prevAvg k %local global.. 이 함수 내에서 선언된 다른 함수에서 사용가능

%    for k = 1:sample_size
%     data = 10.0 + 2*randn(1); % randn(n) = 평균 0 ,표준편차1인 난수 n*n 생성
%     raw_data(k,1) = data;
%     avg_data(k,1) = AvgFilter(data);
%    end
    
    if isempty(first_Run)
        k = 1;
        prevAvg = 0;
        xprev=x(1);
        first_Run = 1;
    elseif k<n
        avg= (prevAvg*(k-1)+x(k))/k;
        prevAvg= avg;
        k=k+1;
    end

    avg = prevAvg + (x(k)-x(k-n))/n;
    
    prevAvg = avg;     
    k = k+1;
end

