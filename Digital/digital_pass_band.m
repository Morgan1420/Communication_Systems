clc;
close all;
addpath('Digital/Moduladors_pb');
addpath('Digital/Demoduladors_pb');
addpath('_generic_functions');

% Missatge a transmetre → Aleix Jorda Banus i Jan Moran Ricardo
missatge = [0 1 0 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0  0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 1];
A = 2;
min_cos_A = .2;
llista_valors = [A, -A];
div = 4000; % intentem que sigui superior a la meitat del delay del canal ja que els receptors accionen en div/2

DMM = 10; % DM = Divisions del Missatge a Mostrar
plot_signal(signal_1=missatge, figure_num=1, title_1='Missage original', axis=[ 0 DMM -1.25 1.25], discreete=true, num_plots=1);

% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Modulador

signals_mod = mod_ask(missatge=missatge, A=A, num_bits=1);


% --------- Ploting senyals del modulador 
plot_signal(signal_1=signals_mod.a, figure_num=2, title_1='a(t) Bipolar', axis=[ 0 100 (-A - .25) (A + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=signals_mod.s, signal_2=signals_mod.S, figure_num=3, title_1='s(t)', title_2='S(f)', axis=[ 0 (div) (-A -min_cos_A - .25) (A +min_cos_A + .25)]);
plot_signal(signal_1=signals_mod.s_mod, signal_2=signals_mod.S_mod, figure_num=4, title_1='s(t)', title_2='S(f)', axis=[ 0 (div) (-A -min_cos_A - .25) (A +min_cos_A + .25)]);

% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Canal
signals_ch = canal(s=signals_mod.s,divisions_pols=div,delay=3);


% --------- Ploting senyals del canal
plot_signal(signal_1=signals_ch.h_c, figure_num=5, title_1='h_c(t)', axis=[ 0 (div) -1.25 1.25], discreete=true, num_plots=1);
plot_signal(signal_1=signals_ch.g, signal_2=signals_ch.G, figure_num=6, title_1='r_c(t)', title_2='R_c(f)', axis=[ 0 (div) (-A -W - .25) (A +W + .25)]);
plot_signal(signal_1=signals_ch.w, figure_num=7, title_1='w(t)', axis=[ 0 (div) (-W - .25) (W + .25)], num_plots=1);
plot_signal(signal_1=signals_ch.r, signal_2=signals_ch.R, figure_num=8, title_1='r(t)', title_2='R(f)', axis=[ 0 (div) (-A- .25) (A + W + .25)]);
