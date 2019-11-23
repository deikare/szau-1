function graniczne = zbioryrozmyte(xmin,xmax, l, dX)
    graniczne = zeros(l, 2); %%funkcja zwraca wartosci ograniczajace konkretny zbior rozmyte
    bounds = (xmax - xmin) / l;
    graniczne(1,1) = xmin - dX / 2;
    graniczne(1, 2) = xmin + bounds + dX / 2;
    for i = 2 : l
        graniczne(i, 1) = graniczne(i-1, 2) - dX;
        graniczne(i, 2) = graniczne(i, 1) + bounds + dX;
    end
end

