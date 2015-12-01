clc;
clearvars;
close all;

I = imread('t021a.png');
h = size(I, 1);
w = size(I, 2);

% Radial illumation
[X, Y] = meshgrid(1:size(I,2),1:size(I,1));
X0 = size(I, 2) / 2;
Y0 = size(I, 1) / 2;

f = exp(-(0.005 * sqrt((X - X0).^2 + (Y - Y0).^2)).^2);
I2 = uint8(double(I) ./ f);


% Drawing
IMAGES = {I, I2};
for i=1:size(IMAGES,2)
    subplot(1,2,i)
    imshow(IMAGES{i});
end