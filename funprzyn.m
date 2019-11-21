function wektorPrzyn = funprzyn(u, n, umin, umax, dU)
%funkcja dostaje sterowanie i uogólnion¹ iloœæ zbiorów rozmytych i oblicza
%wartosci funkcji przynaleznosci
%umin - minimalne sterowanie, umax - maksymalne, dU - skoki trapezow
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    u_length = length(u);
    wektorPrzyn = zeros(u_length, n);
    bounds = (umax - umin) / n; %%obliczanie zakresów "1" na wyjœciu
    a = umin - dU;
    b = umin;
    c = umin + bounds;
    d = c + dU;
    for j = 1 : n
       for i = 1: u_length
          wektorPrzyn(i, j) = trapez(u(i), a, b, c, d); 
       end
       if j == 1
           a = a + bounds + dU;
           b = b + bounds + dU;
       else
           a = a + bounds;
           b = b + bounds;
       end
       if j == n-1
           c = 55000;
           d = 55000;
       else
           c = c + bounds;
           d = d + bounds;
       end
    end
end

