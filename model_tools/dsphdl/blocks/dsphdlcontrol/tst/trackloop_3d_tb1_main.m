% TRACKLOOP_3
%   
% Description:
%   Testbench for 3d Trackloop testbench
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
sys = 'trackloop_3d_tb1';
top = 'trackloop_3d';
dut = [sys '/' top];


%% Select test case.
% Test function is a 3D gaussian with parameters specified below
% if FINV is set, the sin function is negated 
FINV = false;  

% All test cases below can also be run with limits
LIMIT = false;
XMIN = 0;
XMAX = 0;

x1_nt = numerictype(0, 18, 16); % Unsigned [0->1]
x1mean = 1;   
x1sd = .1;    
x1mag = 1;    

x2_nt = numerictype(0, 18, 14); % Unsigned [0->1]
x2mean = 10; 
x2sd = 1;    
x2mag = 1;   

x3_nt = numerictype(0, 18, 10); % Unsigned [0->1]
x3mean = 100;
x3sd = 10;
x3mag = 1;


testcase = 1;
switch testcase
    case 1
        
        x1_init = x1mean - 2*x1sd;
        x1_step = x1sd/10;
        x1_dir  = +1;

        x2_init = x2mean + 2*x2sd;
        x2_step = x2sd/50;
        x2_dir  = +1;

        x3_init = x3mean - 5*x3sd;
        x3_step = x3sd/5;
        x3_dir  = +1;
        
end


open_system(sys)
sim(sys);


%% HDL Code Generation
TargetDirectory = '../hdl';
generatehdl