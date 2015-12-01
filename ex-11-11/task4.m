clc;
clear all;

[I, map] = imread('kids.tif');
RGB = ind2rgb(I, map);


% Simple illumination
[X, Y] = meshgrid(1:size(RGB,2),1:size(RGB,1));
f = 0.001 * (X + Y);
figure, imshow(double(RGB).*repmat(f,[1,1,3]));

% Radial illumation
X0 = size(RGB, 2) / 2;
Y0 = size(RGB, 1) / 2;

f = exp(-(0.007 * sqrt((X - X0).^2 + (Y - Y0).^2)).^2);
figure, imshow(double(RGB).*repmat(f,[1,1,3]));