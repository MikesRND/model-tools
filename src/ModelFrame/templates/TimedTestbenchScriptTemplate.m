%% Testbench initialization script

% Clean environment
clearvars
close all

% Define component under test
sys = 'TESTBENCH_NAME';
dut = 'TESTBENCH_NAME/COMPONENT_NAME';

% Open model project
openModelProject('..');

% System Clock and Period 
Rsys = 1e6;
Tsys = 1/Rsys;

% Get internal component initialization structure
ini = COMPONENT_NAME_init(Tsys);

% Open Model
open_system(sys)

% Set simulation time
Tsim = 10*Tsys;

% Run Simulation
fprintf('Running simulation...')
simOut = sim(sys);
fprintf('done.\n')

% Validate Output
[x, t] = getSimOutput(simOut,'Din');
y = getSimOutput(simOut,'Dout');
assert(all(x==y));
fprintf('Model output validated\n')