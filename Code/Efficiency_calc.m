function [efficiency] = Efficiency_calc(repeated_symbols_prob,n,unique_symb_size,entropy)

ACL = 0;
for i = 1:unique_symb_size
    ACL = ACL + n(i)*repeated_symbols_prob(i);
end

% Calculating the entropy 

efficiency = (entropy / ACL) *100;

end

