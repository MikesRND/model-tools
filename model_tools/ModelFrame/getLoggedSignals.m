function result = getLoggedSignals(opts)
arguments
    opts.Model = '';
    opts.masks (1,1) logical = true
    opts.links (1,1) logical = false
end

if isempty(opts.Model)
    opts.Model = gcs;
end

% Find all lines in the Model
params = {'FindAll', 'on'};
if opts.links
    params = [params, {'FollowLinks', 'on'}];
else
    params = [params, {'FollowLinks', 'off'}];
end
if opts.masks
    params = [params, {'LookUnderMasks', 'all'}];
else
    params = [params, {'LookUnderMasks', 'none'}];
end

lines = find_system(opts.Model, params{:}, 'Type', 'line', 'SegmentType','trunk');

result = {};
ports = get_param(lines,'SrcPortHandle');
for i=1: length(ports)
    port = ports{i};
    if strcmp(get_param(port,'datalogging'),'on')
        rname = get_param(port,'Name');
        [bd, srcblk]= fileparts(get_param(port,'Parent'));
        result = [result, fullfile(bd,srcblk,rname)]; %#ok
        result = strrep(result,'\','/');
    end
end

