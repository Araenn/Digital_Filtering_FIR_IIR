clc; clear; close all

N = input("Choisir N : ");
%pour n0 = 0.2, prendre N = 30
%n0 = 0.1, N = 60
%n0 = 0.05, N = 120
%n0 = 0.01, N = 650
%n0 = 0.005, N = 1200
%Plus fc basse, plus ordre grand

n = (0:N)';
n0 = input("Frequence de coupure [0.2, 0.1, 0.05, 0.01, 0.005] : ");

h = 2*n0*sinc(2*n0*(n - (N/2)));
x1 = 0.8*n0;
x2 = 1.2*n0;
y1 = 0.1;
y2 = 1.1;

k = 500;
[H, w] = freqz(h, 1, k);
tftd_h = abs(H.^2);
phase_h = unwrap(angle(H));
f = w/(2*pi);

ha = hann(N+1);
ht = fir1(N, 2*n0, 'low', ha);

figure(1)
stem(n, h)
hold on
stem(n, ht)
grid()
title("Reponses impulsionnelles  fir avec et sans fenetre")
xlabel("Temps discret")
ylabel("Amplitude")
legend("RI troncature", "RI fenetre")

[NT, w] = freqz(ht, 1, k);
tftd_ht = abs(NT.^2);
phase_ht = unwrap(angle(NT));
f = w/(2*pi);

figure(2)
subplot(2,1,1)
plot(f, tftd_h)
hold on
plot(f, tftd_ht)
plot([x1 x1], [0 0.9], 'm', 'Linewidth', 2)
plot([0 x1], [0.9 0.9], 'm', 'Linewidth', 2)
plot([0 x2], [1.1 1.1], 'm', 'Linewidth', 2)
plot([x2 f(500)], [0.1 0.1], 'm', 'Linewidth', 2)
plot([x2 x2], [0.1 1.1], 'm', 'Linewidth', 2)
grid()
title("Courbes de gain des filtres avec fir")
xlabel("Frequence numerique")
ylabel("Module")
legend("RI troncature", "RI fenetre")

subplot(2,1,2)
plot(f, phase_h/pi)
hold on
plot(f, phase_ht/pi)
grid()
title("Courbes de phase des filtres avec fir")
xlabel("Frequence numerique")
ylabel("Rad")
legend("RI troncature", "RI fenetre")