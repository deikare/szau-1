function [t, y] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym)
%funkcja liczaca model
    [t, y] = ode45(@dstate, tspan, y0, odeset('RelTol',1e-12,'AbsTol',1e-12, 'NonNegative', 1:2));
%     [t, y] = ode45(@dstate, tspan, y0);

    function dydt = dstate(t, y)
        dydt = zeros(2,1);
        F1_act = interp1(0:Tp:Tsym, F1, t); %interpolacja dyskretnych danych dla chwili t
        Fd_act = interp1(0:Tp:Tsym, Fd, t);
        
        if (y(1) < 0)
            y(1) = 0;   %zabezpieczenie przed pierwiastkowaniem ujemnych liczb
        end
        
        if (y(2) < 0)
            y(2) = 0;
        end
        
        dydt(1) = F1_act + Fd_act + a1 * y(1) + b1; %juz zostalo dodane opoznienie
        dydt(2) = a3 * y(1) + a2 * y(2) + b2;
    end
end