function h2lin_w = getH2linW(xmin, xmax, dX, l)
%funkcja dostaje podzielon� na zbiory rozmyte zmienn� i zwraca punkty
%linearyzacji
    h2lin_w = zeros(1, l); %% poziomy, aby da�o sie przechodzi� foreachem
    bounds = (xmax-xmin)/l;
    x0_lin = (bounds - dX/2)/2;
    h2lin_w(1,1) = x0_lin;
    for i = 2 : l
        h2lin_w(1, i) = h2lin_w(1, i-1) + bounds;
    end
end

