clc; clear; close all

N = 20;

o = (-N:N)';
n0 = 0.2;

h = 2*n0*sinc(2*n0*(o - 2*o));
n = (0:length(h)-1)';

figure(1)
stem(n, h)
grid()
title("Reponse impulsionnelle h")
xlabel("Temps discret")
ylabel("Amplitude")

k = 500;
[H, w] = freqz(h, 1, k);
tftd_h = abs(H);
phase_h = unwrap(angle(H));
f = w/(2*pi);

figure(2)
subplot(2,1,1)
plot(f, tftd_h)
grid()
title("Courbe de gain du filtre")
xlabel("Frequence numerique")
ylabel("Module")

subplot(2,1,2)
plot(f, phase_h/pi)
grid()
title("Courbe de phase de h")
xlabel("Frequence numerique")
ylabel("Rad")

nh = h.*hann(2*N+1);

figure(3)
stem(n, h)
hold on
stem(n, nh)
grid()
title("Reponses impulsionnelles avec et sans fenetre")
xlabel("Temps discret")
ylabel("Amplitude")
legend("RI troncature", "RI fenetre")

[NH, w] = freqz(nh, 1, k);
tftd_nh = abs(NH);
phase_nh = unwrap(angle(NH));
f = w/(2*pi);

figure(4)
subplot(2,1,1)
plot(f, tftd_h)
hold on
plot(f, tftd_nh)
grid()
title("Courbes de gain des filtres")
xlabel("Frequence numerique")
ylabel("Module")
legend("RI troncature", "RI fenetre")

subplot(2,1,2)
plot(f, phase_h/pi)
hold on
plot(f, phase_nh/pi)
grid()
title("Courbes de phase des filtres")
xlabel("Frequence numerique")
ylabel("Rad")
legend("RI troncature", "RI fenetre")

ha = hann(2*N+1);
ht = fir1(2*N, 2*n0, 'low', ha);

figure(5)
stem(n, h)
hold on
stem(n, ht)
grid()
title("Reponses impulsionnelles  fir avec et sans fenetre")
xlabel("Temps discret")
ylabel("Amplitude")
legend("RI troncature", "RI fenetre")

[NT, w] = freqz(ht, 1, k);
tftd_ht = abs(NT);
phase_ht = unwrap(angle(NT));
f = w/(2*pi);

figure(6)
subplot(2,1,1)
plot(f, tftd_h)
hold on
plot(f, tftd_ht)
grid()
title("Courbes de gain des filtres avec fir1")
xlabel("Frequence numerique")
ylabel("Module")
legend("RI troncature", "RI fenetre")

subplot(2,1,2)
plot(f, phase_h/pi)
hold on
plot(f, phase_ht/pi)
grid()
title("Courbes de phase des filtres avec fir1")
xlabel("Frequence numerique")
ylabel("Rad")
legend("RI troncature", "RI fenetre")