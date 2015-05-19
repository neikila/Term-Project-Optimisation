function [ result ] = iterate( sourceImg, previousStep, PSF )

    [limitX, limitY] = size(PSF);

    [sizeX, sizeY] = size(sourceImg);
    
    [PSFCenterX, PSFCenterY] = center(limitX, limitY);
    
    inputInEveryPoint = sourceImg;
    result = previousStep;
    
    % ��� ������� ������� �����������
    % ��������� ����� ���������� �����
    % ��� ����� ����������� 
    for i=1:sizeX
        for j=1:sizeY
            

            temp = 0;
            % ������ ������ � ���������� �����
            
            [startI, rightLimit, startJ, topLimit] = getLimits(i, j, limitX, limitY);
            
            for inI=startI:rightLimit
                for inJ=startJ:topLimit
                    temp = temp + getPixelValue(previousStep, inI, inJ, sizeX, sizeY) * PSF(PSFCenterX + (inI - i), PSFCenterY + (inJ - j));
                end
            end
            inputInEveryPoint(i, j) = temp;
        end
    end
    
    % ������ ������������ �� �������� ��� ������� ����� � ������������
    % �������� �������
    for i=1:sizeX
        for j=1:sizeY
            
            
            [startI, rightLimit, startJ, topLimit] = limits(i, j, limitX, limitY, sizeX, sizeY);
            temp = 0;
            
            for inI=startI:rightLimit
                for inJ=startJ:topLimit
                    temp = temp + sourceImg(inI, inJ) * PSF(PSFCenterX + (inI - i), PSFCenterY + (inJ - j)) / inputInEveryPoint(inI, inJ);
                end
            end
            if (temp == 0)
                result(i, j) = previousStep(i, j);
            else
                result(i, j) = previousStep(i, j) * temp;
            end
        end
    end
end