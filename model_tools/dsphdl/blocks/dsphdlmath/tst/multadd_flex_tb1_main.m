% MULTADD_FLEX_TB1_MAIN Main test script
%   
% This script tests the multadd_flex block.
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------


sys = 'multadd_flex_tb1';
top = 'multadd_flex';
dut = [sys '/' top];

% Test force scale
Fscale = 5;

open_system(sys)
sim(sys);

%% HDL Code Generation
TargetDirectory = '../hdl';
generatehdl

