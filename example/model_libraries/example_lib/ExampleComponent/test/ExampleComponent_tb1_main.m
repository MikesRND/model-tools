%% Testbench initialization script

% Clean environment
clearvars
close all

% Define component under test
sys = 'ExampleComponent_tb1';
dut = 'ExampleComponent_tb1/ExampleComponent';

% Open model project
openModelProject('..');

% System Clock and Period 
Rsys = 1e6;
Tsys = 1/Rsys;

% Get internal component initialization structure
ini = ExampleComponent_init(Tsys);

% Open Model
open_system(sys)

% Set simulation time
Tsim = 10*Tsys;

% Run Simulation
simOut = sim(sys);
