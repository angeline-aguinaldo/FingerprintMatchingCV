function [TotError check] = TotalInvariantError(F_pad, D_pad, ErrSub); 

F_L = length(F_pad);
D_L = length(D_pad);

TotError = ErrSub*ones(D_L,D_L);
check = [];

for k = 1:length(D_pad);

    F_shift = circshift(F_pad,k); 
    
    compare = [D_pad F_shift];
    
    check = [check F_shift];
        
    err = abs(compare(find(F_shift ~= 0),1)-compare(find(F_shift ~= 0),2)).^2;    
    TotError(find(F_shift ~= 0), k) = err;
    
end

end