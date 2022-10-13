clc; clear; close all

load("Filtre_RIF_TP1.mat")

P = 20;

%% Generation d'un signal d'entree creneaux
p = zeros(64, 1);
p(1:32) = 1;
p(32:64) = -1;
x = p;

for i = 1:P-1
    x = [x;p];
end

t = (0:size(x)-1)';

figure(1)
plot(t, x)
grid()
title("Signal d'entree x")
xlabel("Temps discret")
ylabel("Amplitude")

k = 500;
[X, w] = freqz(x, 1, k);
tftd_x = 10*log10(abs(X.^2));
f = w/(2*pi);

figure(2)
plot(f, tftd_x)
grid()
title("Spectre de x")
xlabel("Frequence numerique")
ylabel("dB")
%plusieurs harmoniques, fondamental a 0.016 Hz, ampl de 525, puis 0.047 hz
%pour 257 et enfin 0.078 hz et ampl de 153. residus ensuite
%% Importation du filtre
[H, w_h] = freqz(h_RIF, 1, k);
tftd_h = abs(H.^2);
f_h = w_h/(2*pi);

figure(3)
plot(f_h, tftd_h)
grid()
title("Courbe de gain du filtre")
xlabel("Frequence numerique")
ylabel("Module")
%fc = 0.225 Hz
%% Application du filtre
y = filter(h_RIF', 1, x);
[Y, w] = freqz(y, 1, k);
tftd_y = 10*log10(abs(Y.^2)); %pour voir la diff

figure(4)
plot(t, y)
grid()
title("Signal de sortie y")
xlabel("Temps discret")
ylabel("Amplitude")

figure(5)
plot(f, tftd_y)
grid()
title("Spectre de sortie y")
xlabel("Frequence numerique")
ylabel("dB")
%harmoniques + residus jusqu'a 0.25 hz, ensuite rien
%amplitude reduite des harmoniques, frequences inchangees

figure(6)
plot(f, tftd_x)
hold on
plot(f, tftd_y)
grid()
title("Comparaison spectres entree/sortie")
ylabel("dB")
xlabel("Frequence numerique")
legend("Entree x", "Sortie y")