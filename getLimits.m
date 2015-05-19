function [ startI, rightLimit, startJ, topLimit ] = getLimits( i, j, limitX, limitY)

    limitXLeft = round(limitX / 2);
    limitYBottom = round(limitY / 2);
    
    startI = i - limitXLeft + 1;
    rightLimit = startI + limitX - 1; 

    startJ = j - limitYBottom + 1;
    topLimit = startJ + limitY - 1;
    
end

