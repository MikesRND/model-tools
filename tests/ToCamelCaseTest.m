classdef ToCamelCaseTest < matlab.unittest.TestCase
    methods (Test)
        
        function testCamelCase(testCase)
            % Test default behavior (do not capitalize first letter)
            result = toCamelCase('this_is_a_test');
            expected = 'thisIsATest';
            testCase.verifyEqual(result, expected);

            % Test with capitalizeFirst flag set to true
            result = toCamelCase('this_is_a_test', true);
            expected = 'ThisIsATest';
            testCase.verifyEqual(result, expected);

            % Test single word input
            result = toCamelCase('test');
            expected = 'test';
            testCase.verifyEqual(result, expected);

            % Test single word input with capitalizeFirst flag set to true
            result = toCamelCase('test', true);
            testCase.verifyEqual(result, 'Test');

            % Test empty string input
            result = toCamelCase('');
            testCase.verifyEqual(result, '');

            % Test input with no underscores
            result = toCamelCase('thisisatest');
            testCase.verifyEqual(result, 'thisisatest');

            % Test input that is already in camelCase
            result = toCamelCase('thisIsATest');
            testCase.verifyEqual(result, 'thisIsATest');          

            % Test input that is already in camelCase with capitalizeFirst flag set to true
            result = toCamelCase('thisIsATest', true);
            testCase.verifyEqual(result, 'ThisIsATest');              

        end
        
    end
end