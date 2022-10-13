clc; clear; close all

N = 1000;
nu = 0.02;
sigma = 0.25;
t = (0:N-1)';
k = 500; %points frequence
P = 20;

bruit = randn(N, 1); %tftd bruit blanc (ts echantillons statistiquement independants) theorique = cste, pratique = "residus"

%% Generation et affichage du signal d'entree
x = sin(2*pi*nu*t) + sigma*bruit;

figure(1)
plot(t, x)
grid()
xlabel("Temps discret")
ylabel("Amplitude")
title("Signal x")

%% Generation et affichage du spectre du signal d'entree
[X, w] = freqz(x, 1, k); %B = x et A = 1 car RIF
tftd_x = abs(X.^2); % /!\ module = sqrt(x^2+b^2) /!\
f = w/(2*pi);

figure(2)
plot(f, tftd_x)
grid()
xlabel("Fréquence numérique")
ylabel("Module")
title("Spectre de x")
%harmonique unique a 0.02 Hz, 500 amplitude 
%% Generation et application du filtre numerique
n = (0:P-1)';
h = (1/P)*ones(P, 1);

figure(3)
stem(n, h)
grid()
title("Reponse impulsionnelle du filtre moyenneur")
xlabel("Temps discret")
ylabel("Amplitude")

y = filter(h, 1, x);

figure(4)
plot(t, x)
hold on
plot(t, y)
grid()
legend("Signal d'entree x", "Signal de sortie y")
xlabel("Temps discret")
ylabel("Amplitude")
title("Forme d'onde du signal")
%dephasage leger

[Y, w] = freqz(y, 1, k);
tftd_y = abs(Y.^2); 

figure(5)
plot(f, tftd_y)
grid()
title("Spectre de y")
xlabel("Frequence numerique")
ylabel("Module")
%frequence harmonique conservee, amplitude reduite a 376, residus 
%% Reponse en frequence du filtre numerique
[H, w_h] = freqz(h, 1, k);
tftd_h = abs(H.^2);
f_h = w_h/(2*pi);

figure(6)
plot(f_h, tftd_h)
grid()
title("Courbe de gain du filtre moyenneur")
xlabel("Frequence numerique")
ylabel("Module")
%coupe les frequences > 0.02 Hz