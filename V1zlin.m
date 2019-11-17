function v1 = V1zlin(h1, C1, h1_lin)
%funkcja wypluwajaca objetosc2
    v1 = 2 * C1 * h1_lin * h1 - C1 * (power(h1_lin, 2));
end
