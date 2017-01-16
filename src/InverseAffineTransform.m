function [imRecover HullRecover FiducialRecover] = InverseAffineTransform(FprintInfo, f, DatabaseInfo, d)

F_Center = FprintInfo(f).Centroid;
F_ConvexVert = FprintInfo(f).ConvexHullVertex;
F_FG = FprintInfo(f).ForegroundCoor;
F_im = FprintInfo(f).Image;
[F_FidPoints F_Branch] = FiducialPoints(F_Center, F_ConvexVert, F_im);
FprintInfo(f).FiducialPoints = F_FidPoints;

D_Center = DatabaseInfo(d).Centroid;
D_ConvexVert = DatabaseInfo(d).ConvexHullVertex;
D_FG = DatabaseInfo(d).ForegroundCoor;
D_im = DatabaseInfo(d).Image;
[D_FidPoints D_Branch] = FiducialPoints(D_Center, D_ConvexVert, D_im);
DatabaseInfo(d).FiducialPoints = D_FidPoints;

%%
% figure;
% subplot(1,3,1);
% imagesc(F_im); colormap('gray');
% hold on;
% plot(F_Center(1),F_Center(2),'*g','MarkerSize',7);
% plot(F_ConvexVert(:,1), F_ConvexVert(:,2),'.y');
% plot(F_Branch(:,1),F_Branch(:,2),'ob', 'MarkerSize',7);
% title('Sample Fingerprint');
% hold off
% subplot(1,3,2);
% imagesc(D_im); colormap('gray');
% hold on;
% plot(D_Center(1), D_Center(2),'*g', 'MarkerSize',7);
% plot(D_ConvexVert(:,1), D_ConvexVert(:,2),'.y');
% plot(D_Branch(:,1),D_Branch(:,2),'ob', 'MarkerSize',7);
% title('Database');
% hold off
%%

F = MatrixPrep(F_FidPoints);
D = MatrixPrep(D_FidPoints);

A = D \ F; 
A = A(1:3,1:3);
A(3,:) = [0 0 1];

DataRecover = D_FG;

imRecover = zeros(length(DataRecover),3);
for m = 1:length(DataRecover);
      imRecover(m,:) = A*[DataRecover(m,1); DataRecover(m,2); 1];
end

% hold on;
% subplot(1,3,3);
% plot(imRecover(:,1),imRecover(:,2),'.k');
% title('Inverse Transform of Database Image');
% % set(gca,'visible','off');
% hold off

%%

HullRecover = D_ConvexVert;

ConvexHullRecover = zeros(length(HullRecover),3);
for m = 1:length(HullRecover);
      ConvexHullRecover(m,:) = A*[HullRecover(m,:)'; 1];
end

% figure(3);
% hold on
% plot(ConvexHullRecover(:,1),ConvexHullRecover(:,2),'.y');
% hold off

%%

FidDataRecover = D_FidPoints;

FiducialRecover = zeros(length(FidDataRecover),3);
for m = 1:length(FidDataRecover);
      FiducialRecover(m,:) = A*[FidDataRecover(m,:)'; 1];
end

end
               
        
        
        
        