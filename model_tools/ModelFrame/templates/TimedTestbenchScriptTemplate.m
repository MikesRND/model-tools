%% Configure environment and define constants
clearvars
close all

sys = 'TESTBENCH_NAME';
dut = 'TESTBENCH_NAME/COMPONENT_NAME';

% System Clock and Period 
Rsys = 1e6;
Tsys = 1/Rsys;

ini = COMPONENT_NAME_init(Tsys);

% Open Model
open_system(sys)

% Set simulation time
Tsim = 10*Tsys;

% Run Simulation
simOut = sim(sys);
