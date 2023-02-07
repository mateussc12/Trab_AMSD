clc, clear, close all

n = 7;
g = 9.8;
m = sqrt(1/n);
betha_e = 20/n;
Ra = 20/n;
La = 0.1*n;
Kb = 0.1*n;
Ki = 20/n;
Jm = n;
betha = 20/n;

g1 = tf(Ki, [La Ra]);
g2 = tf(1, betha);
g3 = tf(1, [1 0]);
g4 = tf(m*g, [m betha_e 0]);
g5 = tf(m*g, 1);
g6 = tf([Jm 0], 1);
g7 = tf([Kb 0], 1);
tf_sys = (g1*g2*g3*g4) / (1 + g2*g6 + g2*g3*g4*g5 + g1*g2*g3*g7)


[num,den] = tfdata(tf_sys,'v');
raizes = roots(den)
scatter(real(raizes) ,imag(raizes), 50, 'filled', 'red')
hold on
plot([-1*(max(abs(real(raizes)))) - 1, max(abs(real(raizes))) + 1], [0, 0], '--b')
plot([0, 0], [-1*(max(abs(imag(raizes)))) - 1, max(abs(imag(raizes))) + 1], '--b')
xlim([-1*(max(abs(real(raizes)))) - 1, max(abs(real(raizes))) + 1]);
ylim([-1*(max(abs(imag(raizes)))) - 1, max(abs(imag(raizes))) + 1]);
title("Raizes da equacao caracteristica do sistema")
grid;

figure
step(tf_sys, 100)
