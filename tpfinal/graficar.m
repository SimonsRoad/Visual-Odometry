load "out.txt";
figure;
hold on;
plot(out(1:end, 1), out(1:end, 2), "r-o", 'LineWidth',2);
print -dpng "grafico.png";
