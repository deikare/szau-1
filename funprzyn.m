function mi = funprzyn(X,l,xmin, xmax, dX, n)
%%zwraca wartosc funkcji przynaleznosci dla wektora poziomego x
%%n - numer zbioru rozmytego
%%wyjscie
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    bounds = (xmax - xmin) / dX;
    Xlength = length(X);
    granice = zbioryrozmyte(xmin, xmax, l, dX);
    mi = zeros(1, Xlength);
    %%znalezlismy zbior
    if n == l %%aby dla du¿ych h2 zawsze bylo 1 na wyjsciu ostatniego zbioru
        c = 55000;
        d = 55000;
    else
        c = granice(n,2) - dX;
        d = granice(n,2);
    end
                
    if n == 1
        b = granice(n,1);
        a = b - 999999;
    else
        a = granice(n,1);
        b = a + dX;
    end
    i = 1;
    for x = X
        mi(1, i) = trapez(x, a, b, c, d);
        i = i + 1;
    end
end

