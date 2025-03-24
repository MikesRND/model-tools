function [ fm ] = hdlMath()
%HDLFIMATH Create an fimath object for HDL conversion
%  This FI Math object behaves like simple HDL with no rounding or 
%  saturation.
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------



fm = fimath('RoundingMethod', 'Floor',...
            'OverflowAction', 'Wrap',...
            'ProductMode', 'FullPrecision',...
            'MaxProductWordLength', 128,...
            'SumMode', 'FullPrecision',...
            'MaxSumWordLength', 128);
        
end

