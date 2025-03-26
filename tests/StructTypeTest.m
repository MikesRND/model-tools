classdef StructTypeTest < matlab.unittest.TestCase

    methods (Test)
    
        function testConstructor(testCase)
        
            % Test the constructor
            busName = 'TestBus';
            si = StructType(busName);
            testCase.verifyEqual(si.className, busName);
            testCase.verifyEqual(length(si.fields), 0);
            
            % Add some fields
            si.addField('fooSingle','DataType','single');
            si.addField('barFixed','DataType','fixdt(1,16,15)');
            testCase.assertEqual(si.fields(1).name, 'fooSingle');
            testCase.assertEqual(si.fields(2).name, 'barFixed');

        end

        function testDuplicateNameError(testCase)
            % Test adding an field with a duplicate name
            si = StructType('TestBus');
            si.addField('DupName');
            testCase.verifyError(@() si.addField('DupName'),?MException);
        end

        function testaddNestedField(testCase)
            % Test adding a nested BusObject

            % Create the nested BusObject
            nestedStruct = StructType('nestedStruct');
            nestedStruct.addField('nestedStruct','DataType','single');

            % Create the parent BusObject
            parentStruct = StructType('parentStruct');
            parentStruct.addField('parentField');
            parentStruct.addNestedField('nestedStruct',nestedStruct);

        end

        function testDefaults(testCase)
            nestedStruct = StructType('nestedStruct');
            nestedStruct.addField('fooSingle',DataType='single', default=3.14);
            nestedStruct.addField('barBool',DataType='logical', default=true);

            % Create the parent BusObject
            parentStruct = StructType('parentStruct');
            parentStruct.addField('mooStr','DataType','string',default="abc");
            parentStruct.addField('marDouble');
            parentStruct.addNestedField('stuff',nestedStruct);

            % Verify matlab instance
            s = parentStruct.instance();
            testCase.verifyEqual(s.mooStr, "abc")
            testCase.verifyEqual(s.stuff.fooSingle, single(3.14))
            testCase.verifyEqual(s.stuff.barBool, true)

            % Verify simulink bus creation
            bus = parentStruct.getBusObject();
            testCase.verifyEqual(numel(bus.Elements), 3);
            testCase.verifyEqual(bus.Elements(3).DataType, 'Bus: NestedStruct');
            


        end


    end
end