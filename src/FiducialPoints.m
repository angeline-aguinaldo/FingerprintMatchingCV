function [FidPoints Branch] = FiducialPoints(Center, ConvexVertex, Im);

branch = bwmorph(Im,'branchpoints');
[branchy branchx] = find(branch);

Branch = [branchx branchy];

dist = [];
for h = 1:length(Branch);
    a = Branch(h,1) - Center(1);
    b = Branch(h,2) - Center(2);
    temp = sqrt(a^2 + b^2);
    
    dist = [dist; temp h];
end

sortdist = sortrows(dist);

maxidx = sortdist(end,2);
max2idx = sortdist(end-1,2);
minidx = sortdist(1,2);
min2idx = sortdist(2,2);

FidPoints = [Center; Branch(minidx,:); Branch(min2idx,:)];

% PolarCoor = PolarRefCentroid(Center, ConvexVertex);
% 
% [maxval maxidx] = max(abs(PolarCoor(:,2)));
% [minval minidx] = min(abs(PolarCoor(:,2)));
% 


end