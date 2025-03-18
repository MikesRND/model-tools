%% Configure environment and define constants
clearvars
close all

sys = 'ExampleComponent_tb1';
dut = 'ExampleComponent_tb1/ExampleComponent';

% System Clock and Period 
Rsys = 1e6;
Tsys = 1/Rsys;

ini = ExampleComponent_init(Tsys);

% Open Model
open_system(sys)

% Set simulation time
Tsim = 10*Tsys;

% Run Simulation
simOut = sim(sys);
