%#codegen
function [ phase, next ] = phase_counter( en, inc, load, load_val )
%PHASE_COUNTER HDL phase counter
% 
% Description: 
%   Validate phase counter
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

hm = hdlMath();

%% Input validation
persistent initialized;
if isempty(initialized)
    initialized = true;
    
    % Assert data type is fixed point in range [0 to 1)
    nt = numerictype(inc);
    W  = nt.WordLength;
    S  = nt.FractionLength;
    if (S ~= W) 
        error('inc must both have equal fraction and wordlength');
    end

    nt2 = numerictype(load_val);
    if (nt2.WordLength ~= nt2.FractionLength) 
        error('load_val must both have equal fraction and wordlength');
    end
    
end

%% Define internal states
persistent phase_r;
persistent next_r;
if isempty(phase_r)
    phase_r   = fi(0, nt, hm);
    next_r    = false;
end

%% Assign outputs
phase = phase_r;
next  = next_r;

%% Default values



%% Main Behavior

% Convert inc to counter data type
inc_int      = fi(inc,      nt, hm );
load_val_int = fi(load_val, nt, hm );

% Compute full precision result
sum_out = inc_int + phase_r;

% Get rollover bit
roll    = fi(sum_out, 0,1,0, hm);  % Rollover

% Get phase remainder
phase_next = fi(sum_out, nt, hm);

if load
    phase_r = load_val_int;
    next_r  = logical(false);
elseif en
    phase_r = phase_next;
    next_r = logical(roll);
end

















