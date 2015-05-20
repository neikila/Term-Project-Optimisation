function [ result ] = deconvulation( Image, PSF, iterationAmount )

    [red, green, blue] = getRGB(Image);

    iterationRed = red;
    iterationGreen = green;
    iterationBlue = blue;
    
    result = Image;
    
    k = 1;
    count = 0;
    timeTotal = 0;
    while k ~= 0
        count = count + 1;
        Start = cputime;
        for i=1:iterationAmount
            i
            iterationRed = iterate(red, iterationRed, PSF);
            iterationGreen = iterate(green, iterationGreen, PSF);
            iterationBlue = iterate(blue, iterationBlue, PSF);
        end
        Elapsed = cputime - Start
        timeTotal = timeTotal + Elapsed
        result(:,:,1) = iterationRed;
        result(:,:,2) = iterationGreen;
        result(:,:,3) = iterationBlue;
        f = figure(count + 2); imshow(result); title('Deconvulated');
        k = waitforbuttonpress;
    end
end

