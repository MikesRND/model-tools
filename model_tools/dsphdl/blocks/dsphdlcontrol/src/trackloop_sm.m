function [ done,...
           next_done,...
           apply,...
           apply_xval,...
           err,...
           track_state]...
  = trackloop_sm( ...
           init,...
           next,...
           x_init,...
           x_step,...
           x_dir,...
           fx_update,... 
           fx_value,...
           fx_invalid,...
           brk,...
           LIMIT,...
           MINVAL,...
           MAXVAL...
)%#codegen
% TRACKLOOP_SM 
%   
% Description:
%   This loop controller state machine loops continuously while
%   maximizing a function y = fx = f(x).  The range of X may 
%   optionally be limited.
%
%   Note: this process requires hdlMath() to be applied in the Simuilink
%   block math settings
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
x_nt   = numerictype(x_init);
xfp_nt = numerictype(1, x_nt.WordLength + 2, x_nt.FractionLength);
step_nt  = numerictype(x_step); % Assumed be positive
dir_nt   = numerictype(1,2,0);  % -1, 0, or +1


%% Define Registers
persistent state_r;
persistent done_r;
persistent apply_r;
persistent apply_xval_r;
persistent x_step_r;
persistent x_dir_r;
persistent prior_x_r;
persistent prior_fx_r;
persistent next_x_r;
persistent next_fx_r;
persistent next_minlimited_r;
persistent next_maxlimited_r;
persistent next_done_r;
persistent err_r;

if isempty(state_r)
    state_r  = hdlu(state.idle, Wstate);
    done_r   = false;
    apply_r  = false;
    apply_xval_r = fi(0, x_nt);
    x_step_r = fi(0, step_nt);
    x_dir_r = fi(1, dir_nt);
    prior_x_r = fi(0, x_nt);
    prior_fx_r = lowerbound(fx_value);
    next_x_r = fi(0, xfp_nt);
    next_fx_r = lowerbound(fx_value);
    next_minlimited_r = false;
    next_maxlimited_r = false;
    next_done_r = false;
    err_r = false;
end

%% Assign outputs
track_state = state_r;
done = done_r;
apply = apply_r;
apply_xval = apply_xval_r;
next_done = next_done_r;
err = err_r;

    %% Main state machine
    % Default values
    apply_r = false;
    next_done_r = false;
    done_r = false;
    
    switch state_r
        case state.idle
            
            if init
                % Save step and direction for future use
                x_step_r = x_step;
                x_dir_r  = x_dir;
                
                % Store prior x value, init prior fx to minimum
                prior_x_r  = fi(x_init, x_nt);
                prior_fx_r = lowerbound(fx_value);
                
                % Apply prior value, which will initiate measurement
                apply_xval_r = fi(x_init, x_nt);
                apply_r  = true;
                state_r  = hdlu(state.fetch_x0, Wstate);
                
                % Reset error condition
                err_r = false;
            end
            
        case state.fetch_x0
            % Wait for measurement to complete
            if fx_update
                if fx_invalid
                    % Declare error
                    state_r  = hdlu(state.error, Wstate);
                else
                    % Store prior fx value
                    prior_fx_r = fx_value;
                    state_r  = hdlu(state.ready, Wstate);
                    next_done_r = true;
                end
            end
            
        case state.ready
            %% Arriving in this state, prior_x and prior_fx are both valid.
            % Wait for a signal to test the next value
            if brk
                done_r = true;
                state_r  = hdlu(state.idle, Wstate);
            elseif next
                state_r  = hdlu(state.compute, Wstate);
            
            % updates to fx will continue to be accepted to keep prior
            % measurement up to date when other parameters may be changing
            elseif fx_update
                if fx_invalid
                    % Declare error
                    state_r  = hdlu(state.error, Wstate);
                else
                    % Store prior fx value
                    prior_fx_r = fx_value;
                end
            end            

        case state.compute
            %% Compute next coordinate value based on direction
            % This is done with full precision in prep for limiting
            
            % Void SNR result in prep for measurement
            next_fx_r = lowerbound(fx_value);
           
            if x_dir_r > 0
                next_x_r = fi( fi(prior_x_r, xfp_nt) + ...
                               fi(x_step_r,  xfp_nt), ...
                                             xfp_nt);
            elseif x_dir_r < 0
                next_x_r = fi( fi(prior_x_r, xfp_nt) - ...
                               fi(x_step_r,  xfp_nt), ...
                                             xfp_nt);
            end
            state_r = hdlu(state.limitlower, Wstate);

        case state.limitlower
            if LIMIT
                lowerlimit = fi(MINVAL, xfp_nt);
                if next_x_r <= lowerlimit
                    next_x_r = lowerlimit;
                    next_minlimited_r = true;
                else
                    next_minlimited_r = false;
                end
            end
                
            state_r = hdlu(state.limitupper, Wstate);
            
        case state.limitupper
            if LIMIT
                upperlimit = fi(MAXVAL, xfp_nt);
                if next_x_r >= upperlimit
                    next_x_r = upperlimit;
                    next_maxlimited_r = true;
                else
                    next_maxlimited_r = false;
                end
            end
            state_r = hdlu(state.apply_next, Wstate);    
            
        case state.apply_next
            % If LIMIT is false, this will allow overflow due to hdlMath
            apply_xval_r = fi(next_x_r, x_nt);
            apply_r  = true;
            state_r  = hdlu(state.fetch_next, Wstate);
            
        case state.fetch_next
            % Wait for measurement to complete
            if fx_update
                if fx_invalid
                    % Declare error
                    state_r  = hdlu(state.error, Wstate);
                else
                    % Store fx value
                    next_fx_r = fx_value;
                    state_r  = hdlu(state.decision, Wstate);
                end
            end

        case state.error
            %% Assert error and go idle
            err_r = true;
            done_r = true;
            state_r = hdlu(state.idle, Wstate);
            
        case state.decision
            %% Decide which direction to go next
            
            % If current point was MINVAL, force a positive direction
            if next_minlimited_r
                x_dir_r = fi( 1, dir_nt);

            % If current point was MAXVAL, go in negative direction
            elseif next_maxlimited_r
                x_dir_r = fi(-1, dir_nt);

            % Otherwise, change directions if
            %   (a) fx got lower
            %   (b) fx was unmeasurable
            elseif (next_fx_r < prior_fx_r)
                x_dir_r = fi(-x_dir_r, dir_nt);
                
            % Otherwise, continue in same direction    
            end                
            
            next_done_r = true;
            state_r = hdlu(state.ready, Wstate);
            
            %: Store prior values
            prior_x_r  = fi(apply_xval_r, x_nt);
            prior_fx_r = next_fx_r;
            
        otherwise
            state_r = hdlu(state.idle, Wstate);

    end
    
end



function [state, Wstate] = getStates()
    % State bit width
    Wstate = 4;
    state.idle         = 0;
    state.fetch_x0   = 1;
    state.ready        = 2; 
    state.compute      = 3;
    state.limitlower   = 4;
    state.limitupper   = 5;
    state.apply_next   = 6;
    state.fetch_next = 7;
    state.decision     = 8;
    state.done         = 9;
    state.error        = 10;
end
