function wektorPrzyn = funprzynwidok(u, l, umin, umax, dU)
%funkcja dostaje sterowanie i uogólnion¹ iloœæ zbiorów rozmytych i oblicza
%wartosci funkcji przynaleznosci do poszczególnych zbiorow
%umin - minimalne sterowanie, umax - maksymalne, dU - skoki trapezow

    u_length = length(u);
    wektorPrzyn = zeros(u_length, l);
    bounds = (umax - umin) / l; %%obliczanie zakresów przesuwania do kolejnego zbioru rozmytego
    a = - dU; %%produkujemy trapezy
    b = 0;
    c = umin + bounds - dU / 2;
    d = c + dU;
    for j = 1 : l
       for i = 1: u_length
          wektorPrzyn(i, j) = trapez(u(i), a, b, c, d); 
       end
       if j == l-1 %%aby dla du¿ych sterowan zawsze bylo 1 na wyjsciu ostatniego zbioru
           c = 55000;
           d = 55000;
       else
           c = c + bounds;
           d = d + bounds;
       end
       if j == 1
           b = d - bounds;
           a = b - dU;
       else
           a = a + bounds;
           b = b + bounds;
       end
       
    end
end

