function k=count_var(data,number)
    idx=find(data<number); %find안의 식을 만족하는 index 배열화
    k=length(idx); %배열의 크기 측정
end