function [] = MatchFingerprint ( FprintInfo, DatabaseInfo, MatchInfo )

c = length(MatchInfo);

for k = 1:c;
    
    F_idx = MatchInfo(k).FingerprintID;
    D_idx = MatchInfo(k).DatabaseID;
    
    FprintName = FprintInfo(F_idx).Filename;
    DatabaseName = DatabaseInfo(D_idx).Filename;
    minErr = MatchInfo(k).Error;
    
    disp(sprintf([num2str(FprintName) ' matches ' num2str(DatabaseName) ...
        sprintf(' with an error of %d \n', minErr)]));
    
    figure(k)
    subplot(1,2,1)
    imagesc(FprintInfo(F_idx).Image); colormap('gray');
    hold on;
    plot(FprintInfo(F_idx).ConvexHullVertex(:,1),...
        FprintInfo(F_idx).ConvexHullVertex(:,2),'.y');
    set(gca,'xtick',[]); set(gca,'ytick',[]);
    title(num2str(FprintName));
    
    subplot(1,2,2)
    imagesc(DatabaseInfo(D_idx).Image); colormap('gray');
    hold on
    plot(DatabaseInfo(D_idx).ConvexHullVertex(:,1),...
        DatabaseInfo(D_idx).ConvexHullVertex(:,2),'.y');
    set(gca,'xtick',[]); set(gca,'ytick',[]);
    title(num2str(DatabaseName));
    
    hold off
    
end

end