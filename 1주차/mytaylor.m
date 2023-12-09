function fx=mytaylor(k)
    syms x
    y= 2*sin(x-0.6*pi)+0.77;
    x0=0;
    p=0;
    for i=0:k
        p= p+subs((diff(y,x,i))*(x-x0)^i)./(factorial(i));
    end
    p=subs(p,x,-pi:0.01:pi);
    x=-pi:0.01:pi;
fx=p;
