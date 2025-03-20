function newComponent(componentName, opts)

arguments
    componentName (1,:) char
    opts.libFolder (1,:) char = '.'
    opts.style (1,1) string {mustBeMember(opts.style,{'timed','hdl'})} = 'timed'
end

if ~exist(opts.libFolder, 'dir')
    fprintf('ERROR: Library folder %s does not exist\n', componentName)
    return
else
    libFolder = GetFullPath(opts.libFolder);
end


% Create component folder
compDir = fullfile(libFolder, componentName);

if exist(compDir, 'dir')
    fprintf('ERROR: Directory for module %s already exists\n', componentName)
    return
end

% Create directory structure
fprintf('Creating component folders...')
mkdir(compDir);
modelDir = fullfile(compDir,'model');
testDir = fullfile(compDir,'test');
codegenDir = fullfile(compDir,'codegen');
mkdir(modelDir)
mkdir(testDir)
mkdir(codegenDir)
fprintf('Done\n')

% Create Project
fprintf('Creating project...')
proj = createModelProject(componentName, 'projectFolder', compDir);
fprintf('Done\n')

% Create new componnet in its own simuilnk library
fprintf('Creating Simulink library component...')
cd(modelDir);
initFunc = createComponentInitScript(componentName, opts.style); % Create component init script
libName = createSimLibrary(componentName, initFunc, opts.style); % Model itself

newfile = proj.addFolderIncludingChildFiles(modelDir);
proj.addPath(modelDir);
fprintf('Done\n')

% Create testbench
fprintf('Creating component testbench model...')
cd(testDir);
tbName = createSimTestbench(componentName, libName, opts.style);
testScript = createComponentTestScript(componentName);
% Add testbench files to project
newfile = proj.addFolderIncludingChildFiles(testDir);
proj.ProjectStartupFolder=testDir;
proj.SimulinkCodeGenFolder=codegenDir;
fprintf('Done\n')

% Cleanup
fprintf('Cleaning up...')
cd (libFolder);
fclose('all');
proj.close();
fprintf('Done\n')

fprintf('Finished creating component %s at\n', componentName);
fprintf('  %s\n', compDir);
fprintf('To view model and run simulation,\n');
fprintf('change to the \\test subfolder and run:\n');
fprintf('    >> %s\n', testScript);


end



