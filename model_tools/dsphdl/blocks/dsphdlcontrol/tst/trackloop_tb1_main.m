% TRACKLOOP_TB1_MAIN
%   
% Description:
%   Testbench for Tracking loop controller
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------


clear all
close all

activate_dsphdl
sys = 'trackloop_tb1';
top = 'trackloop';
dut = [sys '/' top];


%% Select test case.
% Test function is sin(2*pi*x) with peaks at x = -.75, .25, 1.25
% if FINV is set, the sin function is negated 
FINV = false;  

% All test cases below can also be run with limits
LIMIT = false;
XMIN = 0;
XMAX = 0;

testcase = 11;
switch testcase
    case 1
        % Forward ascent 
        x_nt = numerictype(0, 16, 16); % Unsigned [0->1]
        x_init = 0;
        x_step = 0.01;
        x_dir = +1;

    case 2
        % Forward Ascent Start wrong direction
        x_nt = numerictype(0, 16, 16); % Unsigned [0->1]
        x_init = 0;
        x_step = 0.01;
        x_dir = -1;
        
    case 3
        % Reverse Ascent
        x_nt = numerictype(0, 16, 16); % Unsigned [0->1]
        x_init = 0.7;
        x_step = 0.01;
        x_dir = -1;

    case 4
        % Forward Rollover
        x_nt = numerictype(0, 16, 16); % Unsigned [0->1]
        x_init = 0.8;
        x_step = 0.01;
        x_dir = -1;

    case 5
        % Reverse Rollover
        FINV = true;
        x_nt = numerictype(0, 16, 16); % Unsigned [0->1]
        x_init = 0.2;
        x_step = 0.01;
        x_dir = -1;

    case 10
        % MAX limited
        x_nt = numerictype(1, 16, 12); 
        x_init = 1.8;
        x_step = 0.01;
        x_dir = -1;
        LIMIT = true;
        XMIN = 1;
        XMAX = 2.1;

    case 11
        % MIN limited
        x_nt = numerictype(1, 16, 12); 
        x_init = -0.3;
        x_step = 0.01;
        x_dir = -1;
        LIMIT = true;
        XMIN = -0.6;
        XMAX = 0;
        
end

open_system(sys)
sim(sys);

x  = get_sim_output( logsout, 'x', [], 'fetch' );
fx = get_sim_output( logsout, 'fx_value', [], 'fx_update' );
xlen = length(x);
plot(1:xlen,x,'.', 1:xlen, fx,'.')
grid on


%% HDL Code Generation
TargetDirectory = '../hdl';
generatehdl