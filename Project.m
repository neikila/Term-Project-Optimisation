function [ result ] = Project()
%PROJECT Summary of this function goes here
%   Detailed explanation goes here
    
    I = im2double(imread('Desert.jpg'));
    figure(1); imshow(I); title('�������� �����������');
    
    PSF = fspecial('motion', 10, 0);
    
    Blurred = imfilter(I, PSF, 'circular', 'conv');

    figure(2); imshow(Blurred); title('��������� �����������');
    
    result = deconvulation(Blurred, PSF, 20);

end