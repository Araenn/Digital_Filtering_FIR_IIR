clc; clear; close all

N = input("Choisir N : ");
%pour n0 = 0.2, prendre N = 25
%n0 = 0.1, N = 45
%n0 = 0.05, N = 100
%n0 = 0.01, N = 500
%n0 = 0.005, N = 900
%meme regle, sauf que ordre beaucoup moins grand qu'avec methode fenetre

n = (0:N)';
n0 = 0.2;

x1 = 0.8*n0;
x2 = 1.2*n0;
y1 = 0.1;
y2 = 1.1;

k = 500;

ha = hann(N+1);
ht = fir1(N, 2*n0, 'low', ha);

figure(1)
stem(n, ht)
grid()
title("Reponse impulsionnelle  fir avec fenetre")
xlabel("Temps discret")
ylabel("Amplitude")

[NT, w] = freqz(ht, 1, k);
tftd_ht = abs(NT.^2);
phase_ht = unwrap(angle(NT));
f = w/(2*pi);

f1 = 0;
a1 = 1;
f2 = x1;
a2 = a1;
f3 = x2;
a3 = 0;
f4 = f(500);
a4 = a3;

h = firls(N, 2.*[f1, f2, f3, f4], [a1 a2 a3 a4]);
[H, w] = freqz(h, 1, k);
tftd_h = abs(H.^2);
phase_h = unwrap(angle(H));

figure(2)
subplot(2,1,1)
plot(f, tftd_h)
hold on
plot([x1 x1], [0 0.9], 'm', 'Linewidth', 2)
plot([0 x1], [0.9 0.9], 'm', 'Linewidth', 2)
plot([0 x2], [1.1 1.1], 'm', 'Linewidth', 2)
plot([x2 f(500)], [0.1 0.1], 'm', 'Linewidth', 2)
plot([x2 x2], [0.1 1.1], 'm', 'Linewidth', 2)
grid()
title("Courbe de gain du filtre avec firls")
xlabel("Frequence numerique")
ylabel("Module")

subplot(2,1,2)
plot(f, phase_h/pi)
grid()
title("Courbe de phase du filtre avec firls")
xlabel("Frequence numerique")
ylabel("Rad")