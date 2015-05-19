function [Red, Green, Blue] = getRGB(Image)

Red = Image(:,:,1);
Green = Image(:,:,2);
Blue = Image(:,:,3);
end