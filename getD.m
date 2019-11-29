function D = getD(s, tol)
%%funkcja zwracajaca wielkosc horyzontu dynamiki
    n = length(s);
    s_ust = s(n, 1); %%zakladam ze ostatnia probka ma juz ustalona odpowiedz skokowa
    for i = 1 : n
        if abs(s(i, 1) - s_ust) <= tol %%szukam pierwszej probki, która ma ustalona odpowiedz skokowa
            for j = 1 : 1 %jezeli jest jakas, to wtedy sprawdzam dla 20 nastepnych probek
                if abs(s(i + j, 1) - s_ust) > tol
                    continue; %%jezeli nie pasuje, to szukamy nastepnych
                end
            end
            D = i;
            return
        end
    end
end

