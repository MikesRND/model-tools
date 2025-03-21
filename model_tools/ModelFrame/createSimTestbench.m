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

% Turn on signal logging
set_param(testBenchName,'SignalLogging','on')

% Add device under test
add_block( [libName,'/',componentName], dut);
set_param(dut, 'ShowName','on'); % show name
set_param(dut, 'HideAutomaticName','off'); % show name

% Add stimulus
add_block('simulink/Sources/Sine Wave',   [testBenchName '/Stimulus']);
set_param([testBenchName '/Stimulus'], 'SampleTime', 'Tsys');
set_param([testBenchName '/Stimulus'], 'Frequency', '2*pi/Tsys/8');
lin = add_line(testBenchName,'Stimulus/1',  [componentName '/1']);
set_param(lin,'Name','Din');
set(lin,'DataLogging',1);
set(lin,'DataLoggingLimitDataPoints', 1);
set(lin,'DataLoggingMaxPoints', '1000');

% Add scope
add_block('simulink/Sinks/Scope', [testBenchName '/Scope']);
lout = add_line(testBenchName, [componentName '/1'],  'Scope/1');
set_param(lout,'Name','Dout');
set(lout,'DataLogging',1);
set(lout,'DataLoggingLimitDataPoints', 1);
set(lout,'DataLoggingMaxPoints', '1000');

% Format models
Simulink.BlockDiagram.arrangeSystem(testBenchName)

% Set simulation time
set_param(testBenchName,'StopTime','Tsim');

% Configure model
configureModel(testBenchName, style=style);

% Cleanup
save_system(testBenchName)
close_system(testBenchName)
bdclose(testBenchName);

end
