function [ result ] = iterate( sourceImg, previousStep, PSF )

    [limitX, limitY] = size(PSF);

    [sizeX, sizeY] = size(sourceImg);
    
    [PSFCenterX, PSFCenterY] = center(limitX, limitY);
    
    inputInEveryPoint = sourceImg;
    result = previousStep;
    
    % ��� ������� ������� �����������
    % ��������� ����� ���������� �����
    % ��� ����� ����������� 
    leftEdge = round(limitX/2);
    topEdge = round(limitY/2);
    rightEdge = sizeX - (limitX - leftEdge);
    bottomEdge = sizeY - (limitY - topEdge);
    
    % 1) �������������, �������
    inputInEveryPoint = boundaryCycle(1, sizeX, 1, topEdge, inputInEveryPoint, PSF, previousStep);
    % 2) ������������� ������
    inputInEveryPoint = boundaryCycle(1, sizeX, bottomEdge, sizeY, inputInEveryPoint, PSF, previousStep);
    % 3) ������������� �����
    inputInEveryPoint = boundaryCycle(1, leftEdge, topEdge + 1, bottomEdge - 1, inputInEveryPoint, PSF, previousStep);
    % 4) ������������� ������
    inputInEveryPoint = boundaryCycle(rightEdge, sizeX, topEdge + 1, bottomEdge - 1, inputInEveryPoint, PSF, previousStep);

    for i=(leftEdge + 1):(rightEdge - 1)
        for j=(topEdge + 1):(bottomEdge - 1)

            temp = 0;
            % ������ ������ � ���������� �����

            [startI, rightLimit, startJ, topLimit] = getLimits(i, j, limitX, limitY);
            
            for inI=startI:rightLimit
                for inJ=startJ:topLimit
                    temp = temp + previousStep(inI, inJ) * PSF(PSFCenterX + (inI - i), PSFCenterY + (inJ - j));
                end
            end
            inputInEveryPoint(i, j) = temp;
        end
    end
    
    % ������ ������������ �� �������� ��� ������� ����� � ������������
    % �������� �������
    % 1) �������������, �������
    result = secondIntegrateBoundary (1, sizeX, 1, topEdge, inputInEveryPoint, PSF, result, sourceImg, previousStep );
    % 2) ������������� ������
    result = secondIntegrateBoundary (1, sizeX, bottomEdge, sizeY, inputInEveryPoint, PSF, result, sourceImg, previousStep );
    % 3) ������������� �����
    result = secondIntegrateBoundary (1, leftEdge, topEdge + 1, bottomEdge - 1, inputInEveryPoint, PSF, result, sourceImg, previousStep );
    % 4) ������������� ������
    result = secondIntegrateBoundary (rightEdge, sizeX, topEdge + 1, bottomEdge - 1, inputInEveryPoint, PSF, result, sourceImg, previousStep );

    for i=(leftEdge + 1):(rightEdge - 1)
        for j=(topEdge + 1):(bottomEdge - 1)
            
            
            [startI, rightLimit, startJ, topLimit] = getLimits(i, j, limitX, limitY);
            temp = 0;
            
            for inI=startI:rightLimit
                for inJ=startJ:topLimit
                    temp = temp + sourceImg(inI, inJ) * PSF(PSFCenterX + (inI - i), PSFCenterY + (inJ - j)) / inputInEveryPoint(inI, inJ);
                end
            end
            result(i, j) = previousStep(i, j) * temp;
        end
    end
end