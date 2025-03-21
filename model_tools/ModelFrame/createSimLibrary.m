function libName = createSimLibrary(componentName, initFunc, style, componentVersion)

arguments

    componentName (1,:) char
    initFunc (1,:) char = strcat(componentName,'_init')
    style (1,1) string {mustBeMember(style,{'timed','hdl'})} = 'timed'
    componentVersion (1,1) double {mustBeInteger, mustBePositive} = 1

end

% Create new simulink library
libName = [componentName,'_v',num2str(componentVersion)];
libBlock = [libName,'/',componentName];
new_system( libName, 'Library' );
open_system( libName);
add_block('simulink/Ports & Subsystems/Subsystem', libBlock);
set_param(libBlock, 'ShowName','on');  % show componentName
set_param(libBlock, 'HideAutomaticName','off'); % show componentName
set_param([libBlock '/In1'], 'Name', 'din');
set_param([libBlock '/Out1'], 'Name', 'dout');


% Add mask to block
maskObj = Simulink.Mask.create(gcb);
maskObj.addParameter('Type','edit','Prompt','System clock period','Name','Tsys','Value','Tsys','Container','tab1','Tunable','off');
%maskObj.Parameters(1).DialogControl.PromptLocation='Left';

% Add block to subsystem to demonstrate using init params
add_block('simulink/Sources/Constant',   [libBlock '/Rsys']);
set_param([libBlock '/Rsys'], 'SampleTime', 'Tsys');
set_param([libBlock '/Rsys'], 'Value', 'ini.Rsys');
add_block('simulink/Sinks/Display',   [libBlock '/ShowRsys']);
add_line(libBlock,'Rsys/1','ShowRsys/1')
% Clean up libBlock drawing
Simulink.BlockDiagram.arrangeSystem(libBlock)


% Call init func from mask initialization
init_call = sprintf('ini = %s(Tsys);',initFunc);
maskObj.Initialization = init_call;

% Make block opaque so that all parameters have to be passed through
set_param(gcb,'PermitHierarchicalResolution','None')

% Configure model
configureModel(libName, style=style);


save_system(libName)
close_system(libName)
bdclose(libName);

end


