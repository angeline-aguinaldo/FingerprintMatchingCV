function [TotalError, CircShift] = MatchVertex( FprintInfo, DatabaseInfo );

for f = 1:length(FprintInfo);
    for d = 1:length(DatabaseInfo);
        
        Error = [];
        MatchVertexIdx = [];
        accumError = [];
        
        FprintInvariant = [FprintInfo(f).AreaRatio];
        DatabaseInvariant = [DatabaseInfo(d).AreaRatio];
        
        if length(FprintInvariant) < length(DatabaseInvariant)

            FprintInvariant = padarray(FprintInvariant, ...
                [length(DatabaseInvariant) - length(FprintInvariant)], ...
                0, 'post');

        elseif length(FprintInvariant) > length(DatabaseInvariant)

            DatabaseInvariant = padarray(DatabaseInvariant, ...
                [length(FprintInvariant) - length(DatabaseInvariant)], ...
                0, 'post');

        end
        
        for i = 0:length(FprintInvariant)-1;
            
            DatabaseCirc = circshift(DatabaseInvariant, i);
            
            errTemp = sum(abs(FprintInvariant - DatabaseCirc).^2);

            accumError = [accumError; errTemp i];
                
        end
         
%         errCurrent = accumError(accumError(:,2) == i,:);
        [minError idx] = min(accumError(:,1));
        
        TotalError(d,f) = minError;
        CircShift(d,f) = accumError(idx, 2);

%         Error = [Error; minError];        
%         MatchVertexIdx = [MatchVertexIdx; errCurrent(idx, 2:3)];
        
        end
        
%         TotalError(d,f) = sum(Error);
%         CorrespondVertices{d,f} = MatchVertexIdx;
        
end

end

