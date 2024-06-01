clc;
close all;

% Missatge a transmetre
missatge = [0 1 0 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0  0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 1];
DMM = 10; % DM = Divisions del Missatge a Mostrar
plot_signal(missatge, 1, title='Missage original', axis=[ 0 DMM -1.25 1.25], discreete=true);


% ------------------------------------------------- Modulador

% --------- Codificador de linea: dona l'amplitut correcte al senyal del missatge

A = 2; % Amplitut del missatge 

a=2*A*missatge-A; % Bipolar: Valors A o -A 


plot_signal(a, 2, title='a(t) Bipolar', axis=[ 0 DMM (-A - .25) (A + .25)], discreete=true);

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

plot_signal(p, 3, title='p(t)', axis=[ 0 (div + 1) (-A - .25) (A + .25)], discreete=true);
plot_signal(s, 4, title='s(t)', axis=[ 0 (div * DMM) (-A - .25) (A + .25)]);


% ------------------------------------------------- Canal
% canal ideal amb retard de -6
h_c = zeros(1, div);
h_c(6) = 1;

r_c = conv(s, h_c); % Sortida del canal (sense soroll) 

W = .5; % Amplitut del soroll
w = W*rand(1,length(r));

r = r_c + w; % entrada receptor (amb soroll)




plot_signal(h_c, 5, title='h_c(t)', axis=[ 0 (div + 1) -1.25 1.25], discreete=true);
plot_signal(r_c, 7, title='r_c(t)', axis=[ 0 (div * DMM) (-A -W - .25) (A +W + .25)]);
plot_signal(w, 6, title='w(t)', axis=[ 0 (div * DMM) (-W - .25) (W + .25)]);
plot_signal(r, 8, title='r(t)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);


% ------------------------------------------------- Receptor




% ------------------------------------------------- Altres funcions
