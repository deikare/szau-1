function y = trapez(u, a, b, c, d)
    if u < a
        y = 0;
    elseif u >= a && u < b
        y = (u - a) / (b - a);
    elseif u >= b && u < c
        y = 1;
    elseif u >= c && u < d
        y = (d-u) / (d-c);
    else 
        y = 0;
    end
end

