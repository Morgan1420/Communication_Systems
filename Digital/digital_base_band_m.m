clc;
close all;
addpath('Digital/Moduladors_bb');
addpath('Digital/Demoduladors_bb');
addpath('_generic_functions');

% Missatge a transmetre → Aleix Jorda Banus i Jan Moran Ricardo
missatge = [0 1 0 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0  0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 1];
A = 2;
llista_valors = [A, -A]; % bipolar
% llista_valors = [A, 0]; % unipolar
div = 20; % intentem que sigui superior a la meitat del delay del canal ja que els receptors accionen en div/2

DMM = 10; % DM = Divisions del Missatge a Mostrar
plot_signal(signal_1=missatge, figure_num=1, title_1='Missage original', axis=[ 0 DMM -1.25 1.25], discreete=true, num_plots=1);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Modulador

signals_mod = mod_bipolar_nrz(missatge=missatge, A=A, divisions_pols=div);


% --------- Ploting senyals del modulador 
plot_signal(signal_1=signals_mod.a, figure_num=2, title_1='a(t) Bipolar', axis=[ 0 DMM (-A - .25) (A + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=signals_mod.p, figure_num=3, title_1='p(t)', axis=[ 0 (div + 1) (-A - .25) (A + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=signals_mod.s, signal_2=signals_mod.S, figure_num=4, title_1='s(t)', title_2='S(f)', axis=[ 0 (div * DMM) (-A - .25) (A + .25)]);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Canal
signals_ch = canal(s=signals_mod.s,divisions_pols=div);

% Soroll
W = .5;


% --------- Ploting senyals del canal
plot_signal(signal_1=signals_ch.h_c, figure_num=5, title_1='h_c(t)', axis=[ 0 (div + 1) -1.25 1.25], discreete=true, num_plots=1);
plot_signal(signal_1=signals_ch.g, signal_2=signals_ch.G, figure_num=6, title_1='r_c(t)', title_2='R_c(f)', axis=[ 0 (div * DMM) (-A -W - .25) (A +W + .25)]);
plot_signal(signal_1=signals_ch.w, figure_num=7, title_1='w(t)', axis=[ 0 (div * DMM) (-W - .25) (W + .25)], num_plots=1);
plot_signal(signal_1=signals_ch.r, signal_2=signals_ch.R, figure_num=8, title_1='r(t)', title_2='R(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Receptor


signals_dem = demod_bipolar_nrz(r=signals_ch.r, divisions_pols=div, llista_valors=llista_valors);



% --------- Ploting senyals del receptor
plot_signal(signal_1=signals_dem.y, signal_2=signals_dem.Y, figure_num=9, title_1='y(t)', title_2='Y(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);
plot_signal(signal_1=signals_dem.y_KT, figure_num=10, title_1='y(kT)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=signals_dem.a_KT, figure_num=11, title_1='â(t)', axis=[ 0 (div * DMM) (-A- .25) (A +  .25)], discreete=true, num_plots=1);
plot_signal(signal_1=missatge, signal_2=signals_dem.b_r, figure_num=12, title_1='missatge enviat', title_2='missatge rebut', axis=[ 0 (div * DMM) (-A- .25) (A +  .25)], discreete=true);

disp("Missatge original: " + binary_array_to_ascii(missatge))
disp("Missatge rebut: " + binary_array_to_ascii(signals_dem.b_r))


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Funcions






