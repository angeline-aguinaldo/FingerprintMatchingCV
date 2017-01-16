function [] = CalculateError ( TotalError, FprintInfo, DatabaseInfo )

[r c] = size(TotalError);

for k = 1:c;
    
    [minErr idx] = min(TotalError(:,k));
    FprintName = FprintInfo(k).Filename;
    DatabaseName = DatabaseInfo(idx).Filename;
    
    str = sprintf([num2str(FprintName) ' matches ' num2str(DatabaseName) ...
        sprintf(' with an error of %d \n', minErr)])
    
    figure
    subplot(1,2,1)
    imagesc(FprintInfo(k).Image); colormap('gray');
    subplot(1,2,2)
    imagesc(DatabaseInfo(idx).Image); colormap('gray');
    
    hold off
    
end