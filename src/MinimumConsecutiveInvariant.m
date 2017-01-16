function [kernelMin F_idx D_idx ThreeMinError] = ...
    MinimumConsecutiveInvariant(TotError, kernel, F);

kernelTotErr = -100*ones([size(TotError)]);

for r = 1:length(TotError)
    for t = 1:length(TotError)-kernel+1;
        
        kernelErr = sum(abs(TotError(t:t+kernel-1, r)));
        kernelTotErr(t,r) = kernelErr;
        
    end
end

[kernelMin idx] = min(abs(kernelTotErr(:)));
[i, j] = ind2sub(size(kernelTotErr),idx);

ThreeMinError = TotError(i:i+kernel-1,j);

% b = [FprintInfo(1).AreaRatio(:,1)];
% a = [DatabaseInfo(1).AreaRatio(:,1); zeros(7,1)];
% c = [a circshift(b,j)];

D_idx = i;

if i < j
    F_idx = length(TotError)-(j-i);
elseif i > j
    F_idx = i-j;
elseif i == j;
    F_idx = i;
end

end

