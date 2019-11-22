clear;
umin = 0;
umax = 90;
dU = 0.5;


U = umin: dU: 100;
N = [3 4 5];

fh = figure;
fh.WindowState = 'maximized';
hold on;
tiledlayout(length(N), 1);
for n = N
    nexttile;
    hold on;
    title(['dla n = ', num2str(n)]);
    set(gca, 'XTick', 0:10:180), 
%     axes('XTick', 0:10:umax);
    wektorPrzyn = funprzyn(U, n, umin, umax, 10);
    for i = 1: n
        plot(U, wektorPrzyn(:, i));
        xlabel('y');
        ylabel('\mu');
    end
    
    hold off;
end
hold off;