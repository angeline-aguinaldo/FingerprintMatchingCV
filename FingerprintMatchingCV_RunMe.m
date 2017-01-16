%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Angeline Aguinaldo
% Department of ECE
% Drexel University
%
% ECES681: Fundamentals of Computer Vision
% Final Project
% Mar 17, 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear 
close all
clc

addpath(''); %add src path

%% Pre-Processing and Invariant Processing [Database]

[Database_fname, Database_pathname] = uigetfile( ...
   '*.png', ...
   'Select all Database Images (CTRL + Click)', ...
   'MultiSelect', 'on');

DatabaseImages = Database_fname;
DatabaseInfo = struct('Filename', DatabaseImages', 'Image', [], ...
    'ConvexHullVertex', [], 'TriangleAreas', [], 'AreaRatio', []);

for i = 1:length(DatabaseImages);
      
    im = imread([num2str(Database_pathname) '\' num2str(DatabaseImages{i})]);

    [ bwSkel ] = DatabaseSkel ( im );  %% refine filtering
    DatabaseInfo(i).Image = bwSkel;
    
    [y, x] = find(bwSkel);
    DatabaseInfo(i).ForegroundCoor = [y, x];
    
    [HullVertex Centroid] = GetConvexHull( bwSkel );   
    DatabaseInfo(i).ConvexHullVertex = HullVertex;
    DatabaseInfo(i).Centroid = Centroid;

    TriangleArea = GetTriangleAreas ( HullVertex, Centroid );
    DatabaseInfo(i).TriangleAreas = TriangleArea;
    
    AreaRatio = InvariantAreaRatio( TriangleArea );
    DatabaseInfo(i).AreaRatio = AreaRatio;
    
end

%% Pre-Processing and Invariant Processing [Samples]

[Fprint_fname, Fprint_pathname] = uigetfile( ...
   '*.png', ...
   'Select all Sample Fingerprint Images (CTRL + Click)', ...
   'MultiSelect', 'on');

FprintImages = Fprint_fname;

FprintInfo = struct('Filename', FprintImages', 'Image', [], ...
    'ConvexHullVertex', [], 'TriangleAreas', [], 'AreaRatio', []);

for i = 1:length(FprintImages);
       
    im = imread([num2str(Fprint_pathname) '\' num2str(FprintImages{i})]);

    [ bwSkel ] = DatabaseSkel ( im );
    FprintInfo(i).Image = bwSkel;
    
    [y, x] = find(bwSkel);
    FprintInfo(i).ForegroundCoor = [y, x];
    
    [HullVertex Centroid] = GetConvexHull( bwSkel );   
    FprintInfo(i).ConvexHullVertex = HullVertex;
    FprintInfo(i).Centroid = Centroid;
     
    TriangleArea = GetTriangleAreas ( HullVertex, Centroid );
    FprintInfo(i).TriangleAreas = TriangleArea;
    
    AreaRatio = InvariantAreaRatio( TriangleArea );
    FprintInfo(i).AreaRatio = AreaRatio;
    
end

%% Inverse Affine Transformation

for f = 1:length(FprintInfo);
    for d = 1:length(DatabaseInfo);
        [imRecover HullRecover FiducialRecover] = ...
            InverseAffineTransform(FprintInfo, f, DatabaseInfo, d);
    end
end

%% Comparison/Classification

[MatchInfo] = EstablishCorrespondence( FprintInfo, DatabaseInfo );

MatchFingerprint ( FprintInfo, DatabaseInfo, MatchInfo );



