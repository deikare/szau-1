function f1 = F1out(F1in, Top, n, Tp)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    i = round(Top/Tp);
    f1 = zeros(n, 1);
    f1(1:i, 1) = 0;
    f1(i+1: n, 1) = F1in;
end

