function h2 = h2stat(F1,Fd, alfa2)
    n = length(F1);
    h2 = zeros(n, 1);
    for i = 1 : n
        h2(i, 1) = power(((F1(i, 1) + Fd(i, 1)) / alfa2),2);
    end
end
