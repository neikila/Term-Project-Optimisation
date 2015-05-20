function [ result ] = secondIntegrateBoundary( leftX, rightX, topY, bottomY, inputInEveryPoint, PSF, result, sourceImg, previousStep )
%SECONDINTEGRATEBOUNDARY Summary of this function goes here
%   Detailed explanation goes here
    [limitX, limitY] = size(PSF);
    [sizeX, sizeY] = size(sourceImg);
    [PSFCenterX, PSFCenterY] = center(limitX, limitY);
    for i=leftX:rightX
        for j=topY:bottomY
            
            [startI, rightLimit, startJ, topLimit] = getLimits(i, j, limitX, limitY);
            temp = 0;
            
            for inI=startI:rightLimit
                for inJ=startJ:topLimit
                    sImg = getPixelValue(sourceImg, inI, inJ, sizeX, sizeY);
                    iInEvPoint = getPixelValue(inputInEveryPoint, inI, inJ, sizeX, sizeY);
                    temp = temp + sImg * PSF(PSFCenterX + (inI - i), PSFCenterY + (inJ - j)) / iInEvPoint;
                end
            end
            result(i, j) = previousStep(i, j) * temp;
        end
    end
end

