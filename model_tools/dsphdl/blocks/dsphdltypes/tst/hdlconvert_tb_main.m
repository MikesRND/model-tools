% RNDSAT_TB_MAIN
%   This script tests the rndsat function
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------


WRITE_HDL = true;

sys = 'hdlconvert_tb';
top = 'hdlconvert_demo';
dut = [sys '/' top];

if ~bdIsLoaded(sys)
    load_system(sys)
end
sim(sys);

%% HDL Code Generation
if WRITE_HDL
    TargetDirectory = '../hdl';
    hdlwrite
end
