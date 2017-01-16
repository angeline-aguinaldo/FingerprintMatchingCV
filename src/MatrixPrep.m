function NewMatrix = MatrixPrep(FidPoints);

NewMatrix = zeros(2*length(FidPoints)+1,6);

for m = 1:length(FidPoints);
    NewMatrix(m*2,1) = FidPoints(m,1);
    NewMatrix(m*2,2) = FidPoints(m,2);
    NewMatrix(m*2,3) = 1;
    
    NewMatrix(m*2+1,4) = FidPoints(m,1);
    NewMatrix(m*2+1,5) = FidPoints(m,2);
    NewMatrix(m*2+1,6) = 1;
end

NewMatrix(1,:) = [];

end