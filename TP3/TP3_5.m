clc; clear; close all

meteo = audioread("Meteo1.wav"); 
x = meteo(1901:2600);
N = length(x);
t = (0:N-1)';

figure(1)
plot(t, x)
grid()
title("Forme d'onde de x")
xlabel("Temps discret")
ylabel("Amplitude")

k = 500;
[X, w] = freqz(x, 1, k);
tftd_x = 10*log10(abs(X));
phase_x = unwrap(angle(X));
f = w/(2*pi);

figure(2)
subplot(2,1,1)
plot(f, tftd_x)
grid()
xlabel("Frequence numerique")
ylabel("Gain (dB)")
hold on

for M = [2, 4, 6, 8, 10]
    A = lpc(x, M);
    [Y, w] = freqz(1, A, k);
    tftd_y = 10*log10(abs(Y));
    plot(f, tftd_y)
end
title("Courbes de gain")
legend("Sans filtre", "M = 2", "M = 4", "M = 6", "M = 8", "M = 10")

subplot(2,1,2)
plot(f, phase_x/pi)
grid()
xlabel("Frequence numerique")
ylabel("Rad")
hold on

for M = [2, 4, 6, 8, 10]
    A = lpc(x, M);
    [Y, w] = freqz(1, A, k);
    phase_y = unwrap(angle(Y));    
    plot(f, phase_y/pi)
end
title("Courbes de phase")
legend("Sans filtre", "M = 2", "M = 4", "M = 6", "M = 8", "M = 10")

figure(3)
M = 2;
A = lpc(x, M);

subplot(2,2,[1,3])
r = filter(A, 1, x);
plot(t, x)
hold on
plot(t, r)
grid()
title("Forme d'onde de x et residuels")
xlabel("Temps discret")
ylabel("Amplitude")
legend("Forme d'onde x", "residuels")

subplot(2,2,2)
[Y, w] = freqz(1, A, k);
tftd_y = 10*log10(abs(Y));
[R, w] = freqz(r, 1, k);
tftd_r = 10*log10(abs(R));
plot(f, tftd_y)
hold on
plot(f, tftd_x)
plot(f, tftd_r)
grid()
xlabel("Frequence numerique")
ylabel("Gain (dB)")
title("Courbes de gain, M = 2")
legend("Filtre", "Spectre de x", "residuels")

subplot(2,2,4)
phase_r = unwrap(angle(R));
phase_y = unwrap(angle(Y));   
plot(f, phase_y/pi)
hold on
plot(f, phase_x/pi)
plot(f, phase_r/pi)
grid()
xlabel("Frequence numerique")
ylabel("Rad")
title("Courbes de phase, M = 2")
legend("Filtre", "Spectre de x", "residuels")

figure(4)
M = 4;
A = lpc(x, M);

subplot(2,2,[1,3])
r = filter(A, 1, x);
plot(t, x)
hold on
plot(t, r)
grid()
title("Forme d'onde de x et residuels")
xlabel("Temps discret")
ylabel("Amplitude")
legend("Forme d'onde x", "residuels")

subplot(2,2,2)
[Y, w] = freqz(1, A, k);
tftd_y = 10*log10(abs(Y));
[R, w] = freqz(r, 1, k);
tftd_r = 10*log10(abs(R));
plot(f, tftd_y)
hold on
plot(f, tftd_x)
plot(f, tftd_r)
grid()
xlabel("Frequence numerique")
ylabel("Gain (dB)")
title("Courbes de gain, M = 4")
legend("Filtre", "Spectre de x", "residuels")

subplot(2,2,4)
phase_r = unwrap(angle(R));
phase_y = unwrap(angle(Y));   
plot(f, phase_y/pi)
hold on
plot(f, phase_x/pi)
plot(f, phase_r/pi)
grid()
xlabel("Frequence numerique")
ylabel("Rad")
title("Courbes de phase, M = 4")
legend("Filtre", "Spectre de x", "residuels")

figure(5)
M = 6;
A = lpc(x, M);

subplot(2,2,[1,3])
r = filter(A, 1, x);
plot(t, x)
hold on
plot(t, r)
grid()
title("Forme d'onde de x et residuels")
xlabel("Temps discret")
ylabel("Amplitude")
legend("Forme d'onde x", "residuels")

subplot(2,2,2)
[Y, w] = freqz(1, A, k);
tftd_y = 10*log10(abs(Y));
[R, w] = freqz(r, 1, k);
tftd_r = 10*log10(abs(R));
plot(f, tftd_y)
hold on
plot(f, tftd_x)
plot(f, tftd_r)
grid()
xlabel("Frequence numerique")
ylabel("Gain (dB)")
title("Courbes de gain, M = 6")
legend("Filtre", "Spectre de x", "residuels")

subplot(2,2,4)
phase_r = unwrap(angle(R));
phase_y = unwrap(angle(Y));   
plot(f, phase_y/pi)
hold on
plot(f, phase_x/pi)
plot(f, phase_r/pi)
grid()
xlabel("Frequence numerique")
ylabel("Rad")
title("Courbes de phase, M = 6")
legend("Filtre", "Spectre de x", "residuels")

figure(6)
M = 8;
A = lpc(x, M);

subplot(2,2,[1,3])
r = filter(A, 1, x);
plot(t, x)
hold on
plot(t, r)
grid()
title("Forme d'onde de x et residuels")
xlabel("Temps discret")
ylabel("Amplitude")
legend("Forme d'onde x", "residuels")

subplot(2,2,2)
[Y, w] = freqz(1, A, k);
tftd_y = 10*log10(abs(Y));
[R, w] = freqz(r, 1, k);
tftd_r = 10*log10(abs(R));
plot(f, tftd_y)
hold on
plot(f, tftd_x)
plot(f, tftd_r)
grid()
xlabel("Frequence numerique")
ylabel("Gain (dB)")
title("Courbes de gain, M = 8")
legend("Filtre", "Spectre de x", "residuels")

subplot(2,2,4)
phase_r = unwrap(angle(R));
phase_y = unwrap(angle(Y));   
plot(f, phase_y/pi)
hold on
plot(f, phase_x/pi)
plot(f, phase_r/pi)
grid()
xlabel("Frequence numerique")
ylabel("Rad")
title("Courbes de phase, M = 8")
legend("Filtre", "Spectre de x", "residuels")

figure(7)
M = 10;
A = lpc(x, M);

subplot(2,2,[1,3])
r = filter(A, 1, x);
plot(t, x)
hold on
plot(t, r)
grid()
title("Forme d'onde de x et residuels")
xlabel("Temps discret")
ylabel("Amplitude")
legend("Forme d'onde x", "residuels")

subplot(2,2,2)
[Y, w] = freqz(1, A, k);
tftd_y = 10*log10(abs(Y));
[R, w] = freqz(r, 1, k);
tftd_r = 10*log10(abs(R));
plot(f, tftd_y)
hold on
plot(f, tftd_x)
plot(f, tftd_r)
grid()
xlabel("Frequence numerique")
ylabel("Gain (dB)")
title("Courbes de gain, M = 10")
legend("Filtre", "Spectre de x", "residuels")

subplot(2,2,4)
phase_r = unwrap(angle(R));
phase_y = unwrap(angle(Y));   
plot(f, phase_y/pi)
hold on
plot(f, phase_x/pi)
plot(f, phase_r/pi)
grid()
xlabel("Frequence numerique")
ylabel("Rad")
title("Courbes de phase, M = 10")
legend("Filtre", "Spectre de x", "residuels")

%plus ordre filtre eleve, plus residuels gain bas
%plus ordre eleve, plus fitlre "blanchis"
%ordre 40 proche instabilite, se limiter au M (ordre) minimum necessaire en fonction
%du resultat desire