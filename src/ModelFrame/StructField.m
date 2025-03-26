classdef StructField < handle %#codegen
    % StructField - Define fields for use in a StructType
    % A nestable structured interface that is compatible with
    % Matlab System Objects and Simulink Models.

    properties
        name (1,:) char  % Field name
        Complexity (1,:) char {mustBeMember(Complexity, ['real', 'complex'])} = 'real'  % Field complexity
        Dimensions (1,:) double {mustBeInteger, mustBeNonnegative} = 1  % Field dimensions
        DataType (1,:) char ='double'  % Field data type
        DimensionsMode (1,:) char {mustBeMember(DimensionsMode, ['Fixed', 'Variable'])} = 'Fixed'  % Field dimensions mode
        Description (1,:) char = ''  % Field description
        Unit (1,:) char = ''  % Field unit
        Min (1,:) double = []  % Field minimum value
        Max (1,:) double = []  % Field maximum value
    end

    properties (SetAccess = private)
        defaultValue  % Default value of the field
        busDef  % BusDef representing a nested field
    end

    properties (Dependent, SetAccess = private)
        isNested  % Flag indicating if the field is a nested struct
    end

    methods

        function obj = StructField(name, varargin)

            if nargin < 1
                obj.name = 'fieldName';
            else
                obj.name = name;
            end

            % Handle nested structures first
            % If 'struct' in varargin, 
            args = [varargin{1:2:end}];
            if any(strcmp(args, 'struct'))
                idx = find(strcmp(args, 'struct'));
                busDef = varargin{2*idx};
                varargin(2*idx-1:2*idx) = [];
                obj.busDef = busDef;
                obj.DataType = ['Bus: ' busDef.className];

                % Get default value from the nested struct
                obj.defaultValue = busDef.instance();

                return
            end

            % Continue processing regular field
            
            % If 'default' in varargin, set the default value and remove it from varargin
            args = [varargin{1:2:end}];
            if any(strcmp(args, 'default'))
                idx = find(strcmp(args, 'default'));
                defaultValue = varargin{2*idx};
                varargin(2*idx-1:2*idx) = [];
            end

            % Parse remaining properties field
            for i = 1:2:length(varargin)
                property = varargin{i};
                value = varargin{i+1};
                if isprop(obj, property)
                    obj.(property) = value;
                else
                    error('Invalid property: %s', property);
                end
            end

            % Apply default value
            if exist('defaultValue', 'var')
                if ~isempty(defaultValue)
                    % Note that casting to the same data type causes error
                    if ~strcmp(class(defaultValue), obj.DataType)
                        obj.defaultValue = cast(defaultValue, obj.DataType);
                    else
                        obj.defaultValue = defaultValue;
                    end
                end
            end

        end

        function busElement = makeBusElement(self)
            % Create a Simulink.BusElement from the field
            busElement = Simulink.BusElement;
            busElement.Name = self.name;
            busElement.Complexity = self.Complexity;
            busElement.Dimensions = self.Dimensions;
            busElement.DataType = self.DataType;
            busElement.DimensionsMode = self.DimensionsMode;
            busElement.Description = self.Description;
            busElement.Unit = self.Unit;
            busElement.Min = self.Min;
            busElement.Max = self.Max;
        end

    end

    % Dependent property getters
    methods

        function result = get.isNested(obj)
            result = ~isempty(obj.busDef);
        end
    end


end
