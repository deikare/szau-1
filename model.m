function [t, y] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym)
%funkcja liczaca model
    [t, y] = ode45(@dstate, tspan, y0);
    
    function dydt = dstate(t, y)
        dydt = zeros(2,1);
        F1_act = interp1(0:Tp:Tsym, F1, t);
        Fd_act = interp1(0:Tp:Tsym, Fd, t);
        
        if (y(1) < 0)
            y(1) = 0;   %zabezpieczenie przed pierwiastkowaniem ujemnych liczb
        end
        
        if (y(2) < 0)
            y(2) = 0;
        end
        
        dydt(1) = F1_act + Fd_act - p * nthroot(y(1), 4); %tutaj trzeba dodac opoznienie jakos
        dydt(2) = p * nthroot(y(1), 4) - q * nthroot(y(2), 6);
        disp("ode");
    end
end

