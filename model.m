function [t, y] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym)
%funkcja liczaca model
%     disp(p);
%     disp(q);
    [t, y] = ode45(@dstate, tspan, y0, odeset('RelTol',1e-6,'AbsTol',1e-6));
    
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
        
        dydt(1) = F1_act + Fd_act - p * nthroot(y(1), 4); %juz zostalo dodane opoznienie
        dydt(2) = p * nthroot(y(1), 4) - q * nthroot(y(2), 4);
    end
end

