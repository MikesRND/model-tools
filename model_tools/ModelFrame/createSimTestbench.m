function testBenchName = createSimTestbench(componentName, libName, style)

arguments

    componentName (1,:) char
    libName (1,:) char
    style (1,1) string {mustBeMember(style,{'timed','hdl'})} = 'timed'

end


testBenchName = strcat(componentName,'_tb1');
dut = [testBenchName,'/',componentName];

new_system( testBenchName);
open_system( testBenchName);
add_block( [libName,'/',componentName], dut);
set_param(dut, 'ShowName','on'); % show name
set_param(dut, 'HideAutomaticName','off'); % show name
add_block('simulink/Sources/Constant',   [testBenchName '/stim1']);
set_param([testBenchName '/stim1'], 'Value', '100');
set_param([testBenchName '/stim1'], 'SampleTime', 'Tsys');
add_line(testBenchName,'stim1/1',  [componentName '/1'])
add_block('simulink/Sinks/Scope', [testBenchName '/scope1']);
add_line(testBenchName, [componentName '/1'],  'scope1/1')

% Format models
Simulink.BlockDiagram.arrangeSystem(testBenchName)

% Configure model
configureModel(testBenchName, style=style);

% Cleanup
save_system(testBenchName)
close_system(testBenchName)
bdclose(testBenchName);

end
