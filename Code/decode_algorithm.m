function [decoded,n] = decode_algorithm(transmitted_data,key,unique_symb_size)

% Encoded binary data

% Initialize decoding variables
decoded = '';
buffer = '';

% Decode iteratively by matching prefixes
for i = 1:length(transmitted_data)
    buffer = [buffer, transmitted_data{i}];  % Append next bit to the buffer
    
    % Check if the buffer matches any key
    idx = find(strcmp(buffer, key(:, 1)), 1);
    if ~isempty(idx)
        decoded = [decoded, key{idx, 2}];  % Append the matched symbol
        buffer = '';  % Reset buffer for the next symbol
    end
end

%disp(['Decoded message: ', decoded]);



% getting the nuumber of character that represents each symbol 
for i = 1:unique_symb_size
    n(i) = strlength(key(i,1));
end


end

