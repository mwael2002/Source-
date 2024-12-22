clc;
clear all;

filename=input('Enter the file name : ', 's');
symbols=fileread(filename);

[symbols,symbols_size,unique_symb,unique_symb_size,repeated_symbols_prob] = generating_data(symbols);
[information_gain,entropy] = Information_gain_entropy(repeated_symbols_prob,unique_symb,unique_symb_size)


[transmitted_data_shannon,key_shannon] = Shannon_binary_encode(symbols,symbols_size,unique_symb,unique_symb_size,repeated_symbols_prob);
[decoded_shannon,n_shannon] = decode_algorithm(transmitted_data_shannon,key_shannon,unique_symb_size);

[transmitted_data_huffman,key_huffman] = Huffman_encode(symbols,symbols_size,unique_symb,unique_symb_size,repeated_symbols_prob);
[decoded_huffman,n_huffman] = decode_algorithm(transmitted_data_huffman,key_huffman,unique_symb_size);


[efficiency_shannon] = Efficiency_calc(repeated_symbols_prob,n_shannon,unique_symb_size,entropy)
[efficiency_huffman] = Efficiency_calc(repeated_symbols_prob,n_huffman,unique_symb_size,entropy)

%Comparing input & decoded output from shannon

if(strcmp(decoded_shannon,symbols)~=1)
    display("Error:Shannon Received data not equal input data");
else
    display("Shannon Received data equal input data");
end 

if(strcmp(decoded_huffman,symbols)~=1)
    display("Error: Huffman Received data not equal input data");
else
   display("Huffman Received data equal input data"); 
end   

%Writing output into files to be used in part 2
csvwrite("huffman_output.txt",transmitted_data_huffman);
csvwrite("shannon_output.txt",transmitted_data_shannon);