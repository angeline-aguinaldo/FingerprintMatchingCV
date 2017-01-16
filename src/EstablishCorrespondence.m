function [MatchInfo] = EstablishCorrespondence(FprintInfo, DatabaseInfo);

MatchInfo = struct;

for f = 1:length(FprintInfo);
    
    CompareMin = [];
    
    for d = 1:length(DatabaseInfo);
        
        F = FprintInfo(f).AreaRatio(:,1);
        D = DatabaseInfo(d).AreaRatio(:,1);

        [F_pad D_pad] = PadZero1D(F, D);

        [TotError check] = TotalInvariantError(F_pad, D_pad, -1000); 

         InvariantError = MinimumInvariantError(TotError, -1000);
         
         CompareMin = [CompareMin; InvariantError];

    end
        
        [Min minrow] = min(CompareMin(:,1));

        MatchInfo(f).FingerprintID = f;
        MatchInfo(f).DatabaseID = minrow;
        MatchInfo(f).Error = Min;
        
end

end



