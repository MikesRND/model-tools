function y = hdlconvert(u, extend, signed, maxwidth, scaleopt, roundMode, saturate, Sforce) 
%#codegen
% DSPHDL / hdlconvert
% 
% Description
%   Convenience function for HDL conversion in simulink models.
%   This function performs HDL conversion in a more natural and automatic
%   way than the simulink "convert" block
% 
%   Inputs are integers rather than strings to be compatible with block
%   masks
% 
% Inputs: 
% 
%   u: fixdt
%       Input value
% 
%   signed: int
%       Signedness of output
%           1 = Inherit from input
%           2 = Signed
%           3 = Unsigned
% 
%   maxwidth: int
%       Maximum bit width of output
% 
%   extend: bool
%       If the input width is less than maxwidth, this flag determines
%       whether the width will be extended or kept the same.
% 
%   scaleopt: int
%       Scale optimization strategy.  The following are allowed values
%           1: Maximize output precision
%           2: Maximize output range
%           3: Forced
%
%   roundMode: int
%       Rounding Mode
%           1: Floor (no rounding)
%           2: Nearest
%           3: Convergent
% 
%   saturate: bool
%       Whether or not to perform saturation
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

if isa(u,'double')
    y = u;
    return
end


switch roundMode
    case 1
        roundMode = 'Floor'; 
    case 2
        roundMode = 'Nearest'; 
    case 3
        roundMode = 'Convergent'; 
    otherwise
        roundMode = 'Floor'; 
end

if saturate
    oflowMode = 'Saturate';
else
    oflowMode = 'Wrap';    
end

nt_in    = numerictype(u);

%% Set output width
if maxwidth > nt_in.WordLength
    if extend
        Wout = maxwidth;
    else
        Wout = nt_in.WordLength;
    end
else
    Wout = maxwidth;
end    
Wchange = Wout - nt_in.WordLength;  % Change input length


%% Set output Signedness
switch signed
    case 1 % Inherit
        sign_out = nt_in.Signed;
    case 2 % Signed
        sign_out = true;
    case 3 % Unsigned
        sign_out = false;
    otherwise
        sign_out = true;
end


Sout=0;
%% Set output Scale factor
switch scaleopt
    case 1 % BestPrecision
        if Wchange <= 0 % Width reduction
            % Reduce range bits
            Rout = (nt_in.WordLength - nt_in.FractionLength) + Wchange;
            Sout = Wout-Rout;
        else % width increase
            % Increase precion bits
            Sout = nt_in.FractionLength + Wchange;
        end
    case 2 % Best Range
        if Wchange <= 0 % Width reduction
            % Reduce scale bits
            Sout = nt_in.FractionLength + Wchange;
        else
            %Increase range bits
            Rout = (nt_in.WordLength - nt_in.FractionLength) + Wchange;
            Sout = Wout-Rout;
        end

    case 3 % Forced
        Sout = Sforce;
        
    otherwise
        Rout = (nt_in.WordLength - nt_in.FractionLength) + Wchange;
        Sout = Wout-Rout;
end        

nt_out = numerictype(sign_out, Wout, Sout);

y = fi(u, nt_out, 'RoundingMethod', roundMode, 'OverflowAction',oflowMode);