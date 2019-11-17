function v2 = V2zlin(h2, C2, h2_lin)
%funkcja wypluwajaca objetosc2
    v2 = 2 * C2 * h2_lin * h2 - C2 * (power(h2_lin, 2));
end
