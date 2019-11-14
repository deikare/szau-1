function h1 = H1zlin(V1, C, V1_lin)
    h1 = C * ((V1_lin.^(-1/2))*V1 + sqrt(V1_lin)) / 2;
end

