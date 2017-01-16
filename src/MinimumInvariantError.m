function InvariantError = MinimumInvariantError(TotError, ErrSub);

MinInvar = zeros(length(TotError),1);

for h = 1:length(TotError);
    
    Temp = [TotError(:,h)];
    Temp(Temp == ErrSub) = [];
    Min = sum(Temp);
    
    MinInvar(h) = Min;
    
end

InvariantError = min(MinInvar);

end
