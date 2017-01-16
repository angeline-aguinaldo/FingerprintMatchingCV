function TriAreas = GetTriangleAreas ( HullVertex, Centroid );

numVertex = length(HullVertex);

TriAreas = [];

for j = 1:numVertex - 2;
    TriPoints = [HullVertex(j:j+1, :); Centroid];
    Area = polyarea(TriPoints(:,1),TriPoints(:,2));
    TriAreas = [TriAreas; Area HullVertex(j, :) HullVertex(j+1,:) HullVertex(j+2, :)];
end

TriAreas = sortrows(TriAreas);

end

