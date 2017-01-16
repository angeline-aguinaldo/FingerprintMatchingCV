function [ConvexVert, Centroid] = GetConvexHull( bwSkel )

ConvexHull = bwconvhull(bwSkel);

Center = regionprops(ConvexHull, 'Centroid');
Centroid = Center.Centroid;
ConvexVert = regionprops(ConvexHull, 'ConvexHull');
ConvexVert = [ConvexVert.ConvexHull];

end