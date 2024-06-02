clc;
close all;

% Missatge a transmetre → Aleix Jorda Banus i Jan Moran Ricardo
missatge = [0 1 0 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0  0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 1];
DMM = 10; % DM = Divisions del Missatge a Mostrar
plot_signal(signal_1=missatge, figure_num=1, title_1='Missage original', axis=[ 0 DMM -1.25 1.25], discreete=true, num_plots=1);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Modulador

% --------- Codificador de linea: dona l'amplitut correcte al senyal del missatge

A = 2; % Amplitut del missatge 
llista_valors = [A -A];
a=2*A*missatge-A; % Bipolar: Valors A o -A 


% --------- Conformador de polsos

% Creem una funció pols
div = 20; 
T_pols = 0:1/div:1;
p = square(T_pols);


%Creem senyal transmesa
s = [];
for i=1:length(a)
    s = [s a(i)*p];
end

S = transformada_fourier(s);

% --------- Ploting senyals del modulador 
plot_signal(signal_1=a, figure_num=2, title_1='a(t) Bipolar', axis=[ 0 DMM (-A - .25) (A + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=p, figure_num=3, title_1='p(t)', axis=[ 0 (div + 1) (-A - .25) (A + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=s, signal_2=S, figure_num=4, title_1='s(t)', title_2='S(f)', axis=[ 0 (div * DMM) (-A - .25) (A + .25)]);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Canal
% canal ideal amb retard de -6
h_c = zeros(1, div);
h_c(6) = 1;

r_c = conv(s, h_c); % Sortida del canal (sense soroll) 
R_c = transformada_fourier(r_c);

W = .5; % Amplitut del soroll
w = W*rand(1,length(r_c));

r = r_c + w; % entrada receptor (amb soroll)
R = transformada_fourier(r);


% --------- Ploting senyals del canal
plot_signal(signal_1=h_c, figure_num=5, title_1='h_c(t)', axis=[ 0 (div + 1) -1.25 1.25], discreete=true, num_plots=1);
plot_signal(signal_1=r_c, signal_2=R_c, figure_num=6, title_1='r_c(t)', title_2='R_c(f)', axis=[ 0 (div * DMM) (-A -W - .25) (A +W + .25)]);
plot_signal(signal_1=w, figure_num=7, title_1='w(t)', axis=[ 0 (div * DMM) (-W - .25) (W + .25)], num_plots=1);
plot_signal(signal_1=r, signal_2=R, figure_num=8, title_1='r(t)', title_2='R(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Receptor

% Filtre receptor
h_c = zeros(1, div);
h_c(1) = 1;

y = conv(r,h_c);
Y = transformada_fourier(y);


% Prenem dades cada kT
y_T = [];
for i = (div/2):div+1:length(y)
    y_T = [y_T y(i)];
end


% Detector de nivell - cal modificar per cada modulació (exemple en cas bipolar)
a_r = [];
for i = 1:length(y_T)
    a_r = [a_r findClosestValue(llista_valors, y_T(i))];
end


missatge_r = back_to_binary_bipolar(a_r);

% --------- Ploting senyals del receptor
plot_signal(signal_1=y, signal_2=Y, figure_num=9, title_1='y(t)', title_2='Y(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);
plot_signal(signal_1=y_T, figure_num=10, title_1='y(kT)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=a_r, figure_num=11, title_1='â(t)', axis=[ 0 (div * DMM) (-A- .25) (A +  .25)], discreete=true, num_plots=1);
plot_signal(signal_1=missatge, signal_2=missatge_r, figure_num=12, title_1='missatge enviat', title_2='missatge rebut', axis=[ 0 (div * DMM) (-A- .25) (A +  .25)], discreete=true);

disp("Missatge original: " + binary_array_to_ascii(missatge))
disp("Missatge rebut: " + binary_array_to_ascii(missatge_r))


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Funcions
function closestValue = findClosestValue(arr, x)
    % Calculate the absolute differences between each element in arr and x
    differences = abs(arr - x);
    
    % Find the index of the minimum difference
    [~, index] = min(differences);
    
    % Get the closest value using the index
    closestValue = arr(index);
end

function missatge = back_to_binary_bipolar(a)
    missatge = [];
    for i = 1:length(a)
        if a(i) > 0
            missatge = [missatge 1];
        else
            missatge = [missatge 0];
        end
    end 
    
end



