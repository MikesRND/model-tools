function camelStr = toCamelCase(inputStr, capitalizeFirst)
    if nargin < 2
        capitalizeFirst = false;
    end
    
    % Check if the input string contains underscores
    if ~contains(inputStr, '_')
        camelStr = inputStr;
        if capitalizeFirst
            camelStr = capitalizeFirstLetter(camelStr);
        end
        return;
    end
    
    % Input is snakeCase: Split the string by underscores
    parts = strsplit(inputStr, '_');
    
    % Convert the first part to lowercase or capitalize based on the flag
    if capitalizeFirst
        parts{1} = capitalize(parts{1});
    else
        parts{1} = lower(parts{1});
    end
    
    % Convert the remaining parts to capitalize the first letter without changing the rest
    for i = 2:length(parts)
        parts{i} = capitalizeFirstLetter(parts{i});
    end
    
    % Concatenate the parts
    camelStr = strjoin(parts, '');
end

function str = capitalize(str)
    if ~isempty(str)
        str = [upper(str(1)), lower(str(2:end))];
    end
end

function str = capitalizeFirstLetter(str)
    if ~isempty(str)
        str = [upper(str(1)), str(2:end)];
    end
end