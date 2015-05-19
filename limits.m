function [ startI, rightLimit, startJ, topLimit ] = limits( i, j, limitX, limitY, sizeX, sizeY )
%LIMITS Summary of this function goes here
%   Detailed explanation goes here
    limitXLeft = round(limitX / 2);
    limitYBottom = round(limitY / 2);
    
    startI = i - limitXLeft + 1;
    rightLimit = startI + limitX - 1; 
    
    if startI < 1
        startI = 1;
    end
    if rightLimit > sizeX
        rightLimit = sizeX;
    end

    
    startJ = j - limitYBottom + 1;
    topLimit = startJ + limitY - 1;
    
    if startJ < 1
        startJ = 1;
    end
    if topLimit > sizeY
        topLimit = sizeY;
    end
    
end

