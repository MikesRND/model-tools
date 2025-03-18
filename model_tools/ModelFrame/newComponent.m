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
mkdir(compDir);
modelDir = fullfile(compDir,'model');
testDir = fullfile(compDir,'test');
codegenDir = fullfile(compDir,'codegen');
mkdir(modelDir)
mkdir(testDir)
mkdir(codegenDir)

% Create Project
proj = createModelProject(componentName, 'projectFolder', compDir);

% Create new componnet in its own simuilnk library
cd(modelDir);
initFunc = createComponentInitScript(componentName, opts.style); % Create component init script
libName = createSimLibrary(componentName, initFunc, opts.style); % Model itself

newfile = proj.addFolderIncludingChildFiles(modelDir);
proj.addPath(modelDir);

% Create testbench
cd(testDir);
tbName = createSimTestbench(componentName, libName, opts.style);
testScript = createComponentTestScript(componentName);
% Add testbench files to project
newfile = proj.addFolderIncludingChildFiles(testDir);
proj.ProjectStartupFolder=testDir;
proj.SimulinkCodeGenFolder=codegenDir;

% Cleanup
cd (libFolder);
fclose('all');

fprintf('Finished creating module: %s\n', componentName);
fprintf('To view model and run simulation, open the model project\n');
fprintf('and execute the following command:\n');
fprintf('    >> %s\n', testScript);

proj.close();

end



