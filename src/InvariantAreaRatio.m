function AreaRatio = InvariantAreaRatio( TriangleArea );

AreaRatio = [];

for k = 1:length(TriangleArea)-1;
    Ratio = TriangleArea(k,1)/TriangleArea(k+1,1);
    AreaRatio = [AreaRatio; Ratio, TriangleArea(k,2:end), TriangleArea(k+1,2:end)];
end

AreaRatio(find(isnan(AreaRatio)),:) = [];
AreaRatio(find(AreaRatio == 0),:) = [];

end