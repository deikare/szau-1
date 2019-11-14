function h2 = H2zlin(V2, C, V2_lin)
    h2 = C * ((V2_lin.^(-1/2))*V2 + sqrt(V2_lin)) / 2;
end
