classdef StructType < handle %#codegen
    % StructType - Define structure types for use in Simulink models
    % A nestable structured interface that is compatible with 
    % Matlab System Objects and Simulink Models.

    properties
        className (1,:) char
        numFields (1,1) double {mustBeInteger, mustBeNonnegative} = 0
    end

    properties (Dependent)
        fields  % Returns valid fields
    end

    properties
        fieldstore (1,16) StructField  % Reserved memory for field storage (for code generation)
    end

    methods

        function self = StructType(className)
            % Construct an interface with a given className.
            % The className should use UpperCamelCase format and
            % will be used to define the class in the base workspace
            if nargin < 1
                className = '';
            end
            self.className = toCamelCase(className, true);

            % Initialize field storage
            defaultField = StructField('none');
            self.fieldstore = repmat(defaultField, 1, 16);
        end

        function result = instance(self)
            % Create a matlab structure conforming to the interface
            self.define();  % define the bus in the base workspace
            busObj = self.getBusObject();
            result = busObj.createMATLABStruct(self.className);   
            
            % Set default values
            for field = self.fields
                if ~isempty(field.defaultValue)
                    result.(field.name) = field.defaultValue;
                end
            end
        end
        
        function self = addField(self, name, varargin)
            % Method to add an field to the structure
            % varargin can include Simulink.BusElement properties
            
            % Check for duplicate field names
            if self.numFields > 0
                % Check for duplicate field names
                if any(strcmp(name, {self.fields.name}))
                    error('Field already exists: %s', name);
                end
            end

            % Create a new field with the given properties
            field = StructField(name, varargin{:});
            
            % Add the field to the BusObject
            self.numFields = self.numFields + 1;
            self.fieldstore(1,self.numFields) = field;

        end
        
        function addNestedField(self, name, busDef)
            arguments
                self
                name (1,:) char  % Name of the nested struct
                busDef (1,1) StructType  % Type of the nested struct
            end

            % Add the nested struct as an field
            self.addField(name, 'struct', busDef);

        end
        
        function bus = getBusObject(self)
            % Create a Simulink.Bus object from the StructType definition
            bus = Simulink.Bus;
            bus.Description = self.className;
            bus.Elements = self.getBusElements();
        end

        function busElements = getBusElements(self)
            % Create an array of Simulink.BusElement from the fields
            busElements = [];
            for field = self.fields
                busElements = [busElements, field.makeBusElement()];
            end
        end

        function define(self, ws)
            % Define the BusObject in the base or caller workspace
            % so it can be used by System Objects and Models
            arguments
                self
                ws (1,:) char {mustBeMember(ws, {'base', 'caller'})} = 'base'
            end

            % Define nested BusObjects first
            for field = self.fields
                if field.isNested
                    field.busDef.define(ws);
                end
            end

            % Define the BusObject in the chosen workspace
            if ~self.isDefined(ws)
                assignin(ws, self.className, self.getBusObject());
            end
            
        end

        function result = isDefined(self, ws)
            % Check if the BusObject is defined in the chosen workspace
            arguments
                self
                ws (1,:) char {mustBeMember(ws, {'base', 'caller'})} = 'base'
            end

            result = evalin(ws, sprintf('exist(''%s'', ''var'')', self.className));

        end

        function result = get.fields(self)
            % Method to get the valid fields
            result = [self.fieldstore(1:self.numFields)];
        end

    end
end