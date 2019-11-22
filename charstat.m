const;
u = (0: 0.1 : 150)';
F1_lin_w = 0 : 10 : 150;

nstat = length(u);
Fd = zeros(nstat, 1) + Fd0;
h2_stat = h2stat(u, Fd, al2);
% fh = figure;
% fh.WindowState = 'maximized';
% plot(u, h2_stat);
% axis([0 inf 0 120])
% hold on;
for F1_lin_akt = F1_lin_w
    fh = figure;
    fh.WindowState = 'maximized';
    plot(u, h2_stat);
    title(['punkt linearyzacji = ', num2str(F1_lin_akt)]);
    xlabel('F1');
    ylabel('h2');
    hold on;
    axis([0 inf 0 120])
    y = h2statlin(u, Fd, F1_lin_akt, al2);
    plot(u, y);
    hold off
end

% hold off;