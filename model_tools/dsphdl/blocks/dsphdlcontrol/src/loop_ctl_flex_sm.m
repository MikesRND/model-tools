function [ loop_done, loop_busy, iter_start, iter_break, iter_value, iter_idx ] = loop_ctl_flex_sm( ...
           loop_start, loop_break, initval, stepval, cntval, iter_done...   
)%#codegen
% LOOP_CTL_FLEX_SM Flexible loop controller
%
% Description: 
%   A loop controller intended to maximize flexibility.
%   Not intended for tight loops where very low cycle overhead is desired.
%   No attempt is made to pipeline execution of the iterated task
%
% Loop Parameters
%
%   initval: (fixed point, signed or unsigned)
%       Initial value
%
%   stepval: (fixed point, signed or unsigned)
%       Step value
%
%   cntval: (fixed point integer, unsigned)
%       Number of loop iterations
%
% Loop Control signals
%
%   loop_start: (bool)
%       Start loop
%
%   loop_break: (bool)
%       Break loop.  Asserting loop_break will result in assertion of
%       iter_break.  Use of iter_break by the iterator task is optional.
%
%   loop_done: (bool)
%       Loop done
%
%   loop_busy: (bool)
%       Loop busy
%
% Iterated Task Interface
%
%   iter_start: (bool)
%       Start iterated task
%
%   iter_done: (bool)
%       Iterated task complete
%
%   iter_value: (same type as initval)
%       Current Value of iterator varaible 
%
%   iter_idx: (unsigned integer, same width as cntval)
%       Current iterator index (1->cntval))
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------



%% Define Constants
[state, Wstate] = getStates();  % Main states
cheapmath = hdlMath();          % no rounding or saturation
nt_val = numerictype(initval);
% For cntval, need to handle matlab integer types that caon occur when 
% matlab fixed point types are interpreted as integers 
%(e.g. ufix(16,0) -> uint16)
if isinteger(cntval) 
    width = log2(1+double(intmax(class(cntval))));
    nt_cnt = numerictype(fi(0,0,width,0));
else
    nt_cnt = numerictype(cntval);
end


%% Define Registers
persistent state_r;
persistent loop_count_r;
persistent iter_value_r;
persistent step_value_r;
persistent loop_done_r;
persistent iter_start_r;
persistent iter_value_next_r;
persistent loop_busy_r;
persistent iter_idx_r;
persistent iter_idx_next_r;
persistent iter_break_r;
persistent loop_broken_r;
if isempty(state_r)
    state_r         = hdlu(state.idle, Wstate);
    loop_count_r    = hdlu(0, nt_cnt.WordLength);
    iter_idx_r      = hdlu(0, nt_cnt.WordLength);
    iter_idx_next_r = hdlu(0, nt_cnt.WordLength);
    iter_value_r = fi(0, nt_val, cheapmath);
    step_value_r = fi(0, nt_val, cheapmath);
    iter_value_next_r = fi(0, nt_val, cheapmath);
    loop_done_r  = false;
    iter_start_r = false;
    loop_busy_r = false;
    iter_break_r = false;
    loop_broken_r = false;
end

%% Assign outputs
iter_value = iter_value_r;
loop_done  = loop_done_r;
iter_start = iter_start_r;
loop_busy  = loop_busy_r;
iter_idx   = iter_idx_r;
iter_break = iter_break_r;

%% Capture look break input
if loop_break
    loop_broken_r = true;
end

%% Default values
loop_done_r = false;
iter_start_r = false;
loop_busy_r = false;

%% Pass break signal through
% Immediately breaks all subtasks
% Some applications might want a more orderly break sequence
iter_break_r = loop_broken_r;

%% Main state machine
switch state_r
    
    case state.idle
        loop_broken_r = false;
        
        if loop_start
            if cntval > 0
                
                % Prepare first iteration
                loop_count_r    = hdlu(cntval,  nt_cnt.WordLength);
                iter_idx_r      = hdlu(0,       nt_cnt.WordLength);
                iter_value_r    = fi(initval, nt_val, cheapmath);
                step_value_r    = fi(stepval, nt_val, cheapmath); % cast to initval
                loop_busy_r     = true;
                
                % Start first iteration
                iter_start_r = true;
                state_r      = hdlu(state.iter_started, Wstate);
            else
                % Nothing to do
                loop_done_r = true;
            end
        end
        
    case state.iter_started
        
        % iter_start_r always asserted coming into this state.
        
        loop_busy_r = true;
        
        % Update loop counters and (done here for speed)
        loop_count_r    = loop_count_r - 1;
        iter_idx_next_r = iter_idx_r + 1;
        
        % Compute next iteration value (no saturation or overflow)
        iter_value_next_r = fi(iter_value_r + step_value_r, nt_val, cheapmath);
        
        % Go Wait
        state_r      = hdlu(state.iter_wait, Wstate);
           
        
    case state.iter_wait
        
        loop_busy_r = true;
        
        if iter_done
            
            if loop_count_r > 0 && ~loop_broken_r
                
                % Prepare next iteration
                iter_value_r  = iter_value_next_r;
                iter_idx_r    = iter_idx_next_r;
                
                % Start next iteration
                iter_start_r = true;
                state_r      = hdlu(state.iter_started, Wstate);
                
            else
                state_r = hdlu(state.loop_done, Wstate);
                loop_done_r = true;
            end
            
        end

    case state.loop_done
        
        loop_busy_r = false;
        state_r     = hdlu(state.idle, Wstate);
        
    otherwise
        state_r = hdlu(state.idle, Wstate);
        
end

    
end



function [state, Wstate] = getStates()
    % State bit width
    Wstate = 2;
    state.idle         = 0; 
    state.iter_started = 1;
    state.iter_wait    = 2;
    state.loop_done    = 3;
end
