function [information_gain_per_symbol,entropy] = Information_gain_entropy(repeated_symbols_prob,unique_symb,unique_symb_size)

    information_gain=zeros(1,unique_symb_size);

    for i=1:unique_symb_size
    
    information_gain(i) = -log2(repeated_symbols_prob(i));
    
    end
    
    
    information_gain_per_symbol = [num2cell(unique_symb); num2cell(information_gain)];

entropy = -sum(repeated_symbols_prob .* log2(repeated_symbols_prob));


end

