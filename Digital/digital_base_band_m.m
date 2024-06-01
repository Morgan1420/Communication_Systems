clc;
close all;

% Missatge a transmetre
missatge = [0 1 0 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0  0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 1];
DMM = 10; % DM = Divisions del Missatge a Mostrar
plot_signal(signal_1=missatge, figure_num=1, title_1='Missage original', axis=[ 0 DMM -1.25 1.25], discreete=true, num_plots=1);


% ------------------------------------------------- Modulador

% --------- Codificador de linea: dona l'amplitut correcte al senyal del missatge

A = 2; % Amplitut del missatge 

a=2*A*missatge-A; % Bipolar: Valors A o -A 


plot_signal(signal_1=a, figure_num=2, title_1='a(t) Bipolar', axis=[ 0 DMM (-A - .25) (A + .25)], discreete=true, num_plots=1);

% --------- Conformador de polsos

% Creem una funció pols de f=10kHz 
div = 20; 
T_pols = 0:1/div:1;
p = square(T_pols);


%Creem senyal transmesa
s = [];
for i=1:length(a)
    s = [s a(i)*p];
end

S = transformada_fourier(s);

plot_signal(signal_1=p, figure_num=3, title_1='p(t)', axis=[ 0 (div + 1) (-A - .25) (A + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=s, signal_2=S, figure_num=4, title_1='s(t)', title_2='S(f)', axis=[ 0 (div * DMM) (-A - .25) (A + .25)]);


% ------------------------------------------------- Canal
% canal ideal amb retard de -6
h_c = zeros(1, div);
h_c(6) = 1;

r_c = conv(s, h_c); % Sortida del canal (sense soroll) 
R_c = transformada_fourier(r_c);

W = .5; % Amplitut del soroll
w = W*rand(1,length(r_c));

r = r_c + w; % entrada receptor (amb soroll)
R = transformada_fourier(r);



plot_signal(signal_1=h_c, figure_num=5, title_1='h_c(t)', axis=[ 0 (div + 1) -1.25 1.25], discreete=true, num_plots=1);
plot_signal(signal_1=r_c, signal_2=R_c, figure_num=6, title_1='r_c(t)', title_2='R_c(f)', axis=[ 0 (div * DMM) (-A -W - .25) (A +W + .25)]);
plot_signal(signal_1=w, figure_num=7, title_1='w(t)', axis=[ 0 (div * DMM) (-W - .25) (W + .25)], num_plots=1);
plot_signal(signal_1=r, signal_2=R, figure_num=8, title_1='r(t)', title_2='R(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);


% ------------------------------------------------- Receptor
h_c = zeros(1, div);
h_c(1) = 1;

y = conv(r,h_c);
Y = transformada_fourier(y);

plot_signal(signal_1=y, signal_2=Y, figure_num=9, title_1='y(t)', title_2='Y(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);



