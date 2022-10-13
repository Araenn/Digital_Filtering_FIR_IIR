clc; clear; close all

load("Filtre_RII_PB.mat");

k = 500;
[H, w] = freqz(B, A, k);
tftd_h = abs(H);
phase_h = unwrap(angle(H));
f = w/(2*pi);

figure(1)
subplot(2,1,1)
plot(f, tftd_h)
grid()
title("Courbe de gain du filtre RII")
xlabel("Frequence numerique")
ylabel("Module")

subplot(2,1,2)
plot(f, phase_h/pi)
grid()
title("Courbe de phase du filtre RII")
xlabel("Frequence numerique")
ylabel("Rad")
%dephasage max = -5 dB

figure(2)
zplane(B, A, k)
title("Diagramme zero/pole filtre RII")

zero = roots(B);
r1 = sqrt(real(zero(1))^2 + imag(zero(1))^2);
phi = zeros(length(zero), 1);
rho = zeros(length(zero), 1);
for i = 1:length(zero)
    phi(i) = atan(imag(zero(i))/real(zero(i)))/(2*pi);
    rho(i) = sqrt(real(zero(i))^2 + imag(zero(i))^2);
end

% nz = [0.9*r1*exp(2*1j*pi*phi(1)); 0.9*r1*exp(2*1j*pi*phi(3))];
% nzc = [conj(nz(1)); conj(nz(2))];
% 
% np = [r1*exp(2*1j*pi*phi(1)); r1*exp(2*1j*pi*phi(3))];
% npc = [conj(np(1)); conj(np(2))];
% 
% nB = 1.25*poly([nz(1) nzc(1) nz(2) nzc(2)]);
% nA = poly([np(1) npc(1) np(2) npc(2)]);

% figure(3)
% zplane(nB, nA, k)
% title("Filtre passe-tout")

% nB = conv(B, nB);
% nA = conv(A, nA);

b0 = 1/172;
bi = b0*poly(zero(5:9));
be = poly([rho(1)*exp(2*1j*pi*phi(1)) rho(2)*exp(2*1j*pi*phi(2)) rho(3)*exp(2*1j*pi*phi(3)) rho(4)*exp(2*1j*pi*phi(4))]);
bet = fliplr(be);
hb = conv(bi, bet);

figure(4)
zplane(hb, A, k)
title("Nouveau filtre (H*passe-tout)")

[NH, w] = freqz(hb, A, k);
tftd_nh = abs(NH);
phase_nh = unwrap(angle(NH));

figure(5)
subplot(2,1,1)
plot(f, tftd_nh)
grid()
title("Courbe de gain du nouveau filtre")
xlabel("Frequence numerique")
ylabel("Module")

subplot(2,1,2)
plot(f, phase_nh/pi)
grid()
title("Courbe de phase du nouveau filtre")
xlabel("Frequence numerique")
ylabel("Rad")

ord = 50;
x = zeros(ord, 1);
x(1) = 1;
n = (0:ord-1)';

[X, w] = freqz(x, 1, k);
tftd_x = abs(X);

y1 = filter(B, A, x);
y2 = filter(hb, A, x);

h1 = filter(x, 1, y1);
h2 = filter(x, 1, y2);

figure(7)
stem(n, h1)
hold on
stem(n, h2)
grid()
title("Reponses impulsionnelles des filtres RII et phase minimale")
xlabel("Temps discret")
ylabel("Amplitude")
legend("Filtre RII", "Filtre phase minimale")
%regime transitoire legerement plus court phase minimale