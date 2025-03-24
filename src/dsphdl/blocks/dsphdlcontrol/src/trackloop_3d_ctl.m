function [ done,...
           busy,...
           slave_init,...
           slave1_iter,...
           slave2_iter,...
           slave3_iter,...
           slave_break,...
           track_state]...
  = trackloop_3d_ctl( ...
           start,...
           loop_break,...
           hold1,...
           hold2,...
           hold3,...
           next_done,...
           slave_done...
)%#codegen
% TRACKLOOP_3D_CONTROL
%   
% Description:
%   A top level loop controller that handles control flow for
%   the 3d tracking.  This version of the controller simply
%   flows through 3d for each 
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------


%% Define Constants
[state, Wstate] = getStates();     % Main states


%% Define Registers
persistent state_r;
persistent init_r;
persistent done_r;
persistent slave1_iter_r;
persistent slave2_iter_r;
persistent slave3_iter_r;
persistent slave_break_r;
persistent busy_r;
persistent loop_broken_r;
persistent slave_ctr_r;
if isempty(state_r)
    state_r  = hdlu(state.idle, Wstate);
    init_r = false;
    done_r = false;
    slave1_iter_r = false;
    slave2_iter_r = false;
    slave3_iter_r = false;
    slave_break_r = false;
    busy_r = false;
    loop_broken_r = false;
    slave_ctr_r = hdlu(0, 2);
end

%% Assign outputs
track_state = state_r;
slave_init = init_r;
done = done_r;
slave1_iter = slave1_iter_r;
slave2_iter = slave2_iter_r;
slave3_iter = slave3_iter_r;
slave_break = slave_break_r;
busy = busy_r;

    %% Capture break input and pass through
    if loop_break
        loop_broken_r = true;
    end
    


    %% Main state machine
    % Default values
    done_r   = false;
    init_r   = false;
    slave1_iter_r = false;
    slave2_iter_r = false;
    slave3_iter_r = false;
    slave_break_r  = false;
    
    switch state_r
        
        case state.idle
            
            loop_broken_r = false;
            busy_r = false;
            
            if start
                state_r = hdlu(state.init, Wstate);
                init_r = true;
                busy_r = true;
                slave_ctr_r = hdlu(0, 2);
            end
                
        case state.init
            % Wait for slave_init to complete
            if next_done
                if ~loop_broken_r
                    state_r = hdlu(state.slave_iter, Wstate);
                else
                    state_r = hdlu(state.broken, Wstate);
                end                    
            end
            
        case state.slave_iter
            
            if loop_broken_r
                state_r = hdlu(state.broken, Wstate);
            else
                switch slave_ctr_r
                    case 0
                        if ~hold1
                            slave1_iter_r = true;
                            state_r = hdlu(state.slave_wait, Wstate);
                        end
                    case 1
                        if ~hold2
                            slave2_iter_r = true;
                            state_r = hdlu(state.slave_wait, Wstate);
                        end
                    case 2
                        if ~hold3
                            slave3_iter_r = true;
                            state_r = hdlu(state.slave_wait, Wstate);
                        end

                end
            end
            %: Increment slave counter
            if slave_ctr_r == 2
                slave_ctr_r = hdlu(0,2);
            else
                slave_ctr_r = slave_ctr_r + 1;
            end
            
        case state.slave_wait
            %% Wait for slave to complete
            if next_done
                if ~loop_broken_r
                    state_r = hdlu(state.slave_iter, Wstate);
                else
                    state_r = hdlu(state.broken, Wstate);
                end
            end                

        case state.broken
            %% Break slave loop and wait for it to return
            slave_break_r = true;
            if slave_done
                state_r = hdlu(state.idle, Wstate);
                busy_r = false;
                done_r = true;               
                slave_break_r = true;
            end                

            
        otherwise
            state_r = hdlu(state.idle, Wstate);
            busy_r = false;
            done_r = true;               

    end
    
end



function [state, Wstate] = getStates()
    % State bit width
    Wstate = 4;
    state.idle         = 0;
    state.init         = 1;
    state.slave_iter   = 2;
    state.slave_wait   = 3;
    state.error        = 4;
    state.broken       = 5;
end
