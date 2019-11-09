function [t, y] = model(tspan, y0, F1, Fd, p, q)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [t, y] = ode45(@dstate, tspan, y0);
    
    function dydt = dstate(t, y)
        dydt = zeros(2,1);
        dydt(1) = F1(t) + Fd(t) - p * nthroot(y(1), 4);
        dydt(2) = p * nthroot(y(1), 4) - q * nthroot(y(2), 6);
    end
end

