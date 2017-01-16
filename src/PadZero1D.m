function [F_pad D_pad] = PadZero1D(F, D);

L1 = length(F);
L2 = length(D);

if L1 < L2
    F_pad = [F; zeros(L2-L1,1)];
    D_pad = D;
elseif L1 > L2
    D_pad = [D; zeros(L1-L2,1)];
    F_pad = F;
else
    D_pad = D;
    F_pad = F;
end

end