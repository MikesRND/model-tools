function modelConfig = configureModel(modelName, opts)
% CONFIGUREMODEL Configure the model for code generation

arguments
    modelName (1,:) char
    opts.style (1,1) string {mustBeMember(opts.style,{'timed','hdl'})} = 'timed'
end

% Open the model
load_system(modelName);



if strcmp(opts.style, 'timed')
    % Set solver to FixedStepDiscrete
    set_param(modelName, 'Solver', 'FixedStepDiscrete');
    % Prevent algebraic loops (ArtificialAlgebraicLoopMsg)
    set_param(modelName, 'AlgebraicLoopMsg', 'error');

elseif strcmp(opts.style, 'hdl')
    hdlsetup(modelName);

end

% Get config set
modelConfig = getActiveConfigSet(modelName);

end