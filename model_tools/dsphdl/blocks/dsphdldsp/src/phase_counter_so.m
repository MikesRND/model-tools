classdef phase_counter_so < matlab.System 
%% phase_counter_so HDL Phase Counter system object
%
% Description
%   Phase counter system object
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

%% Class Properties
    
    properties (Nontunable)
    % Public mask properties
        
        WordLength = 8 
        % Number of bits
        
    end
    
    properties
    % Public mask properties (tunable)
    end
    
    properties (Nontunable, Access = private)
    % Internal properties, set in setupImpl
    
        nt
        % Numeric type of phase counter
        
    end
    
    properties (Constant,  Access = private)
    % Internal Constants
    end
    
    properties (DiscreteState)
    % Internal states
        
        phase_r;
        % Internal phase counter
        
        next_r;
        % Phase rollover indicator
        
    end
    
%% Public Methods
methods

    % Constructor
    function obj = phase_counter_so(varargin)
        
        % Set properties according to name value pairs.
        setProperties(obj,nargin,varargin{:},'WordLength');
        
    end
    
    % NumericType getter
    function nt = getNumericType(obj)
        nt = obj.nt;
    end
    
end

   
%% Protected Methods
methods (Access = protected)

    % Validate properties
    function validatePropertiesImpl(obj)
        assert ( (rem(obj.WordLength,1) == 0) );  % Positive
        assert (     (obj.WordLength > 0) );    % Integer
    end
    
    % Validate inputs
    function validateInputsImpl(obj, en, inc, load, load_val)
        if ~isa(inc,'embedded.fi') || ~isa(load_val,'embedded.fi')
            error('step inputs must be fixed point');
        end
    end

    % Setup internal constants (don't validate in this method)
    function setupImpl(obj, en, inc, load, load_val)

        %: unsigned, range:[0,1)
        obj.nt = numerictype(0,obj.WordLength,obj.WordLength);
       
    end

    % Reset class
    function resetImpl(obj)
        hm = hdlMath();
        obj.phase_r     = fi(0, obj.nt, hm);
        obj.next_r      = false;
    end

    % Main behavior
    function [phase, next ] = stepImpl(obj, en, inc, load, load_val)

        % Local constants
        hm = hdlMath();
        
        %---------------------------------
        % Assign Outputs
        %---------------------------------
        phase = obj.phase_r;
        next  = obj.next_r;

        %---------------------------------
        % Main behavior
        %---------------------------------
        
        % Convert inc to counter data type
        inc_int      = fi(inc,      obj.nt, hm );
        load_val_int = fi(load_val, obj.nt, hm );
        
        % Compute full precision result
        sum_out = inc_int + obj.phase_r;
        
        % Get rollover bit
        roll    = fi(sum_out, 0,1,0, hm);  % Rollover
        
        % Get phase remainder
        phase_next = fi(sum_out, obj.nt, hm);
        
        if load
            obj.phase_r = load_val_int;
            obj.next_r  = logical(false);
        elseif en
            obj.phase_r = phase_next;
            obj.next_r = logical(roll);
        end


    end %: Main

end %: Protected Methods
    
end %:classdef


