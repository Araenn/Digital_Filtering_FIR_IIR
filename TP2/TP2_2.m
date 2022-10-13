clc; clear; close all

b0 = 0.15;
r = 1/0.95;
n1 = 0.15;
p = r*exp(2*1j*pi*n1);
pc = conj(p);
k = 500;

%% Generation de la fonction de transfert du filtre et affichages
B = b0;
a1 = -pc - p;
a2 = p*pc;
% A = [1 a1 a2];

A = poly([p, pc]);
figure(1)
zplane(B, A)
title("Diagramme pole et zeros")
xlabel("Partie reelle")
ylabel("Partie imaginaire")
%pole en dehors cercle unite : filtre instable
[H, w] = freqz(B, A, k);
tftd_h = abs(H);
f = w/(2*pi);

figure(2)
plot(f, tftd_h)
grid()
title("Courbe de gain du filtre")
xlabel("Frequence numerique")
ylabel("Module")
%meme courbe de gain qu'avant, aucune autre indication
%% Application du filtre AR
N = 1000;
n2 = 0.02;
t = (0:N-1)';

x = sin(2*pi*n1*t) + sin(2*pi*n2*t);

figure(3)
plot(t, x)
grid()
title("Signal x")
xlabel("Temps discret")
ylabel("Amplitude")

[X, w] = freqz(x, 1, k);
tftd_x = abs(X);

figure(4)
plot(f, tftd_x)
grid()
title("Spectre de x")
xlabel("Frequence numerique")
ylabel("Module")

y = filter(B, A, x);
[Y, w] = freqz(y, 1, k);
tftd_y = abs(Y);

figure(5)
plot(t, x)
hold on
plot(t, y)
grid()
title("Signal de sortie y")
xlabel("temps discret")
legend("Entree x", "Sortie y")
ylabel("Amplitude")

figure(6)
plot(f, tftd_y)
grid()
title("Spectre de sortie")
xlabel("Frequence numerique")
ylabel("Module")

x = zeros(100, 1);
x(1) = 1;
n = (0:100-1)';

[X, w] = freqz(x, 1, k);
tftd_x = abs(X);

y = filter(B, A, x);
[Y, w] = freqz(y, 1, k);
tftd_y = abs(Y);

h = filter(x, 1, y);
figure(7)
stem(n, h)
grid()
title("Reponse impulsionnelle du filtre AR")
xlabel("Temps discret")
ylabel("Amplitude")
%reponse impulsionnelle tend vers infini, filtre instable