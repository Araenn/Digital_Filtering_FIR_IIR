clc; clear; close all

N = 500;
a = 2.5e-4;
b = 0.01;
k = 2000;
n = (0:N-1)';

%% Chirp

x = sin(2*pi*(a.*n+b).*n);
[X, w] = freqz(x, 1, k);
tftd_x = abs(X);
f = w/(2*pi);

figure(1)
plot(n, x)
grid()
title("Forme d'onde de x")
xlabel("Temps discret")
ylabel("Amplitude")

figure(2)
plot(f, tftd_x)
grid()
title("Spectre de x")
xlabel("Frequence numerique")
ylabel("Module")

%% Filtrage RIF
nu = [0.1; 0.2];
L = 40;
ha = hann(L+1);
h = fir1(L, 2.*nu, 'bandpass', ha);
[H, w] = freqz(h, 1, k);
f = w/(2*pi);
tftd_h = abs(H);
phase_h = unwrap(angle(H));

figure(3)
subplot(2,1,1)
plot(f, tftd_h)
grid()
title("Courbe de gain du RIF")
xlabel("Frequence numerique")
ylabel("Module")

subplot(2,1,2)
plot(f, phase_h)
grid()
title("Courbe de phase du RIF")
xlabel("Frequence numerique")
ylabel("Gain")

[Gd, W] = grpdelay(h, 1, k);
gd = abs(Gd);
fg = W/(2*pi);
delay = mean(gd);
%delay = 110;

figure(4)
plot(fg, gd)
grid()
title("Retard de groupe")
xlabel("Frequence numerique")
ylabel("Module")

y = filter(h, 1, x);
[Y, w] = freqz(y, 1, k);
tftd_y = abs(Y);

figure(5)
subplot(2,1,1)
plot(n, x)
hold on
plot(n, y)
grid()
title("Formes d'onde de x et y")
xlabel("Temps discret")
ylabel("Amplitude")

yb = y;
yb(1:delay) = [];

plot(n(1:end-delay), yb)
legend("Entree x", "Sortie y", "Shift")

subplot(2,1,2)
plot(f, tftd_x)
hold on
plot(f, tftd_y)
grid()
title("Spectres de x et y")
xlabel("Frequence numerique")
ylabel("Module")

%% Filtre ARMA
r = 0.85;
r2 = 0.999;

p = [r*exp(2*1j*pi*0.10); r*exp(2*1j*pi*0.15); r*exp(2*1j*pi*0.20)];
z = [r2*exp(2*1j*pi*0.05); r2*exp(2*1j*pi*0.25); r2*exp(2*1j*pi*0.40)];
zc = [conj(z(1)); conj(z(2)); conj(z(3))];
pc = [conj(p(1)); conj(p(2)); conj(p(3))];

A = poly([p(1) pc(1) p(2) pc(2) p(3) pc(3)]);
B = poly([z(1) zc(1) z(2) zc(2) z(3) zc(3)])/45;

[Y, w] = freqz(B, A, k);
tftd_y = abs(Y);
phase_y = angle(Y);

[Gd, W] = grpdelay(B, A, k);
gd = abs(Gd);
fg = W/(2*pi);
delay = mean(gd);

figure(6)
zplane(B, A)
title("Diagramme pole/zeros du filtre ARMA")

figure(7)
plot(n, x)
hold on
plot(n, y)
grid()
title("Formes d'onde de x et y ARMA")
xlabel("Temps discret")
ylabel("Amplitude")

yb = y;
yb(1:delay) = [];

plot(n(1:end-delay+1), yb)
legend("Entree x", "Sortie y ARMA", "Shift")

figure(8)
plot(f, 10*log10(tftd_h))
hold on
plot(f, 10*log10(tftd_y))
grid()
title("Courbes de gain des RIF et ARMA")
xlabel("Frequence numerique")
ylabel("Module")
legend("RIF", "ARMA")