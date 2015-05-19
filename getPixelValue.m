function [ result ] = getPixelValue( previousStep, x, y, sizeX, sizeY  )
%GETPIXELVALUE Summary of this function goes here
%   Detailed explanation goes here
    if x < 1
        x = 1;
    end
    if x > sizeX
        x = sizeX;
    end
    
    if y < 1
        y = 1;
    end
    if y > sizeY
        y = sizeY;
    end
    
    result = previousStep(x, y);

end

