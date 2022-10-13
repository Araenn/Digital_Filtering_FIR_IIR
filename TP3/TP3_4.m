clc; clear; close all

n0 = 0.25;
D = 0.05;
nu = [n0-D; n0+D];

k = 500;

figure(1)
subplot(2,1,1)
for i = [10,20,50,100]
    ha = hann(i+1);
    ht = fir1(i, 2*nu, 'bandpass', ha);
    [NT, w] = freqz(ht', 1, k);
    tftd_ht = abs(NT);
    f = w/(2*pi);
    plot(f, tftd_ht)
    hold on
end
grid()
title("Courbes de gain des filtres RIF")
xlabel("Frequence numerique")
ylabel("Module")
legend("N = 10", "N = 20", "N = 50", "N = 100")

subplot(2,1,2)
for i = [10,20,50,100]
    ha = hann(i+1);
    ht = fir1(i, 2.*nu, 'bandpass', ha);
    [NT, w] = freqz(ht', 1, k);
    phase_ht = unwrap(angle(NT));
    f = w/(2*pi);
    plot(f, phase_ht/pi)
    hold on
end
grid()
title("Courbes de phase des filtres RIF")
xlabel("Frequence numerique")
ylabel("Rad")
legend("N = 10", "N = 20", "N = 50", "N = 100")

figure(2)
subplot(2,1,1)
n = (0:1000)';
h = 2*nu(1)*sinc(2*nu(1)*n) - 2*nu(2)*sinc(2*nu(2)*n);
for M = [4, 6, 8, 20]
    A = lpc(h, M);
    [H, w] = freqz(1, A, k);
    tftd_h = abs(H./H(250));
    f = w/(2*pi);
    plot(f, tftd_h)
    hold on
end
grid()
title("Courbes de gain des filtres AR")
xlabel("Frequence numerique")
ylabel("Module")
legend("M = 4", "M = 6", "M = 8", "M = 20")

subplot(2,1,2)
for M = [4, 6, 8, 20]
    A = lpc(h, M);
    [H, w] = freqz(1, A, k);
    phase_h = unwrap(angle(H./H(250)));
    f = w/(2*pi);
    plot(f, phase_h/pi)
    hold on
end
grid()
title("Courbes de phase des filtres AR")
xlabel("Frequence numerique")
ylabel("Rad")
legend("M = 4", "M = 6", "M = 8", "M = 20")