function [transmitted_data,key] = Shannon_binary_encode(symbols,symbols_size,unique_symb,unique_symb_size,repeated_symbols_prob,n)

index_space = strfind(unique_symb, ' ');
index_enter = strfind(unique_symb, newline);

%Finding each alpha values 


a(1)=0;

for j=2:unique_symb_size
    a(j)=a(j-1)+repeated_symbols_prob(j-1);
end

% Finding each code length

for i=1:unique_symb_size
    n(i)= ceil(-1*(log2(repeated_symbols_prob(i))));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Computing each code

z=[];

for i=1:unique_symb_size
    int=a(i);
for j=1:n(i)
    frac=int*2;
    c=floor(frac);
    frac=frac-c;
    z=[z c];
    habinaryStr = num2str(z); % Convert to string and add spaces
    encoded_binary{i} = strrep(habinaryStr, ' ', ''); % Remove the spaces
    % Encoded binary contains the Code value for each unique charechter
    int=frac;
end
z=[];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Encoding the data of the txt file
for i=1:symbols_size

    for j=1:unique_symb_size

        if(unique_symb(j)==symbols(i))

            transmitted_data_shannon(i)=encoded_binary(j);
          
            break;

        end    

    end   

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Concatenating all the transmitted data 

transmitted_data = []; % THe array which will hold the Binary
transmitted_data = {strjoin(transmitted_data_shannon, '')}; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Splitting each Bit into its own cell 

transmitted_data = cellstr(transmitted_data{1}');
transmitted_data = transmitted_data';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The KEYYYYYYYYYYYYYYYYYYYYYYYYY

unique_symb = cellstr(unique_symb(:))';
key = [encoded_binary;unique_symb];
key = key';

key{index_space,2}=' ';
key{index_enter,2}=char(10);
end