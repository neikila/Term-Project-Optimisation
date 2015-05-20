function [ inputInEveryPoint ] = boundaryCycle( leftX, rightX, topY, bottomY, inputInEveryPoint, PSF, img)
%BOUNDARYCYCLE Summary of this function goes here
%   Detailed explanation goes here
    [limitX, limitY] = size(PSF);
    [sizeX, sizeY] = size(img);
    [PSFCenterX, PSFCenterY] = center(limitX, limitY);

    for i=leftX:rightX
        for j=topY:bottomY
            temp = 0;
            % Расчет вклада в конкретную точку
            
            [startI, rightLimit, startJ, topLimit] = getLimits(i, j, limitX, limitY);
            
            for inI=startI:rightLimit
                for inJ=startJ:topLimit
                    temp = temp + getPixelValue(img, inI, inJ, sizeX, sizeY) * PSF(PSFCenterX + (inI - i), PSFCenterY + (inJ - j));
                end
            end
            inputInEveryPoint(i, j) = temp;
        end
    end
end

