function [t, y] = model(tspan, y0, F1, Fd, p, q)
%funkcja liczaca model
    [t, y] = ode45(@dstate, tspan, y0);
    
    function dydt = dstate(t, y)
        dydt = zeros(2,1);
        dydt(1) = F1 + Fd - p * nthroot(y(1), 4); %tutaj trzeba dodac opoznienie jakos
        dydt(2) = p * nthroot(y(1), 4) - q * nthroot(y(2), 6);
    end
end

