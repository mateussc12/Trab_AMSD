clc, clear, close all

% Código feito por:
% Mateus Souza Coelho
% Kaique de Oliveira Barcellos

n = 7;
alpha = 20/n;
betha = n;
gamma = sqrt(n/10);

% Resposta ao degrau
tf = 0.01 * n; % Periodo de amostragem
t = 0:tf:tf*750; % Vetor tempo
u = zeros(1, length(t));
u(t>=1) = 1;
degrau = [u; u]; % degrau
x_0 = [20/n, 20/n, n]; % estado inical

% Matriz de estados contínua
A = [
    - alpha - betha*(20/n), -betha*(20/n), 0;
    -betha*(20/n), -gamma - betha*(20/n), 0;
    alpha, gamma*(40/n), 0
    ];
B = [
    1, 0;
    0, 1;
    0, 0
    ];
C = [
    0, 1, 0;
    0, 0, 1
    ];
D = [
    0, 0;
    0, 0
    ];

% Colocando a matriz no comando State space, para retornar um modelo de sistema
ss_sys = ss(A, B, C, D)
% Excutando a reposta ao degrau com o lsim no vetor tempo escolhido
[resposta_cont, t_cont, ~] = lsim(ss_sys, degrau, t, x_0);
figure
subplot(2,1,1)
plot(t_cont, resposta_cont(:, 1), 'DisplayName','y1/u')
ylabel("Amplitude")
xlabel("Tempo [s]")
legend()
subplot(2,1,2)
plot(t_cont, resposta_cont(:, 2), 'DisplayName','y2/u')
ylabel("Amplitude")
xlabel("Tempo [s]")
legend()

% Tornando o sistema Discreto com o comando c2d
discrete_sys = c2d(ss_sys, tf)
% Excutando a reposta ao degrau com o lsim no vetor tempo escolhido e periodo de amostragem escolhido
[resposta_dis, t_dis, ~] = lsim(discrete_sys, degrau, t, x_0);
figure
subplot(2,1,1)
plot(t_dis, resposta_dis(:, 1), 'DisplayName','y1/u')
ylabel("Amplitude")
xlabel("Tempo [s]")
legend()
subplot(2,1,2)
plot(t_dis, resposta_dis(:, 2), 'DisplayName','y2/u')
ylabel("Amplitude")
xlabel("Tempo [s]")
legend()

info_cont = stepinfo(resposta_cont, t_cont);
info_cont.RiseTime;
info_cont.SettlingTime;
info_cont.Overshoot;

info_dis = stepinfo(resposta_dis, t_dis);
info_dis.RiseTime;
info_dis.SettlingTime;
info_dis.Overshoot;
