function [transmitted_data,sortedCodes] = Huffman_encode(symbols,symbols_size,unique_symb,unique_symb_size,repeated_symbols_prob)

%% Generating Huffman tree %%

fullTree = [(1:unique_symb_size)', repeated_symbols_prob', zeros(unique_symb_size, 1), zeros(unique_symb_size, 1)]; 
    % fullTree columns: [index, probability, left_child, right_child]

    % Working array for merging
    tree = fullTree;

    % Building the Huffman tree
    while size(tree, 1) > 1
        
        % Sort the new tree with decending order arter each merging
        tree = sortrows(tree, -2);

        % Merge the two smallest nodes (last two rows)
        leftChild = tree(end-1, 1);   % Second smallest node
        rightChild = tree(end, 1);   % Smallest node
        newProb = tree(end-1, 2) + tree(end, 2);  % Combined probability

        % Add a new parent node to the fullTree
        newNodeIndex = max(fullTree(:, 1)) + 1; % Generate a new index
        fullTree = [fullTree; newNodeIndex, newProb, leftChild, rightChild];

        % Remove the last two rows and add the new parent node to the working tree
        tree = tree(1:end-2, :);
        tree = [tree; newNodeIndex, newProb, leftChild, rightChild];
    end

    % Now the array (tree) has a single row which is the root of the Huffman tree
    root = tree(end, :);
    

    

    codes = GenerateHuffmanCodes(fullTree, root(1), unique_symb, '');
    codes(:, [1, 2]) = codes(:, [2,1]);
    
    
%% 
% Assuming 'Codes' is a cell array where each row is [binary_pattern, symbol]
% and 'unique_symb' is the array of unique symbols.
% Initialize a new cell array to store the sorted codes
sortedCodes = cell(unique_symb_size, 2);

% To make codes sorted according to their order in the unique_symb Array

% Loop through the unique symbols to match and sort the codes

for i = 1:unique_symb_size
    % Find the index of the symbol in 'Codes'
    idx = find(strcmp(unique_symb(i), codes(:, 2)), 1); 
    
    % Add the corresponding code to the sortedCodes array

    sortedCodes{i, 1} = codes{idx, 1};  % Store the binary code
    sortedCodes{i, 2} = codes{idx, 2};  % Store the symbol
end

%%%%%


for i=1:symbols_size

    for j=1:unique_symb_size

        if(unique_symb(j)==symbols(i))
            transmitted_data_huffman(i)=sortedCodes(j,1); 
            break;

        end    

    end   

end


% Concatenating all the transmitted data 

transmitted_data = [];
transmitted_data = {strjoin(transmitted_data_huffman, '')};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Splitting each Bit into its own cell 

transmitted_data = cellstr(transmitted_data{1}');

% Transposing the result
transmitted_data = transmitted_data';
    
    
%% Generating the codes %%  
    
    
function codes = GenerateHuffmanCodes(fullTree, nodeIndex, unique_symb, currentCode)
    % Look for the current node in the tree
    row = fullTree(fullTree(:, 1) == nodeIndex, :);

    % Check if it's a leaf node (no children)
    if row(3) == 0 && row(4) == 0
        
        % Leaf node: print symbol and code
        codes = {unique_symb(nodeIndex), currentCode};
     
    else
        % Internal node: go to its children (left and right)
        leftCodes = GenerateHuffmanCodes(fullTree, row(3), unique_symb, strcat(currentCode, '0')); % Left
        
        rightCodes = GenerateHuffmanCodes(fullTree, row(4), unique_symb, strcat(currentCode, '1')); % Right
        
        codes = [leftCodes; rightCodes];
    end
end
    
end
