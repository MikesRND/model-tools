% PHASE_COUTNER_SO_TB1 Phase coutner testbench
%
% Description: 
%   This testbench exercises the phase_counter_so system object
%   from Matlab.
%
%   THis file also serves to set up the phase_counter_tb2 simulation
%   that verifies identical behavior between the matlab function block
%   and the system object.
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
addpath ../src

%% Init simulation
Rs = 1;

%% Instantiate DUT
WordLength = 12;
pc1 = phase_counter_so(WordLength);
nt_in = numerictype(0,WordLength, WordLength);

%% Initialize inputs
Nsim = 500;
en(1:Nsim)       = true;
inc(1:Nsim)      = fi(0.1, nt_in);
load(1:Nsim)     = false;
load_val(1:Nsim) = fi(0.9, nt_in);
load(25) = true;
load(73) = true;

%% Preallocate outputs
phase(1:Nsim) = fi(0, nt_in);
next(1:Nsim) = false;

%% Run simulation
for k = 1:Nsim
    [ phase(k), next(k)] = pc1(en(k), inc(k), load(k), load_val(k));
end

%% Display results
Tsim = Nsim/Rs;
scope = dsp.TimeScope(4, Rs);
scope.LayoutDimensions = [4,1];
scope.TimeSpan = Tsim;
scope.PlotType = 'Stairs';
for k = 1:Nsim    
    step(scope, inc(k), phase(k), next(k), load(k));
end
    
