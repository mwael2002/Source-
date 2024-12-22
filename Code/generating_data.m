function [symbols,symbols_size,unique_symb,unique_symb_size,repeated_symbols_prob] = generating_data(symbols)

%% Extracting the symbols %%

unique_symb=unique(symbols);
[~,symbols_size]=size(symbols);
[~,unique_symb_size]=size(unique_symb);

%% Generating symbols frequancies %%

repeated_symbols=zeros(1,unique_symb_size);

for i=1:unique_symb_size

    for j=1:symbols_size

        if(unique_symb(i)==symbols(j))
        repeated_symbols(i)=repeated_symbols(i)+1;
        end
    end    

end

%% Ordering the symbols and their probabilities in decending order %%

[repeated_symbols, idx] = sort(repeated_symbols,'descend');
unique_symb = unique_symb(idx);

repeated_symbols_prob=repeated_symbols./symbols_size;


end
