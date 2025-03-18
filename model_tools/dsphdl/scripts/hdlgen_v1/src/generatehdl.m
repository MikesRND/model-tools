%GENERATEHDL HDL generation script 
%   
% Description:
%   This is a utility script that allows the hdlwrite script to be
%   called from a makefile/command line.
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------



if getenv('MAKEHDL')
    hdlwrite
end

% Exit matlab if not running from command line
if ~usejava('desktop')
    close_system(sys, 0); % close without saving
    exit
end

