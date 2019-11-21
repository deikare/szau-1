function wektorPrzyn = funprzyn(u, n, umin, umax, dU)
%funkcja dostaje sterowanie i uogólnion¹ iloœæ zbiorów rozmytych i oblicza
%wartosci funkcji przynaleznosci do poszczególnych zbiorow
%umin - minimalne sterowanie, umax - maksymalne, dU - skoki trapezow

    u_length = length(u);
    wektorPrzyn = zeros(u_length, n);
    bounds = (umax - umin) / n; %%obliczanie zakresów przesuwania do kolejnego zbioru rozmytego
    a = umin - dU; %%produkujemy trapezy
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
       if j == n-1 %%aby dla du¿ych sterowan zawsze bylo 1 na wyjsciu
           c = 55000;
           d = 55000;
       else
           c = c + bounds;
           d = d + bounds;
       end
    end
end

