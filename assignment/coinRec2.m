% coinRec2.m
% Utilizes MATLAB Image Processing Toolbox.

% Cleaning.
clc; clearvars; close all;

% Load image.

% I  = imread('test_images/test_img1.jpg');
% Ig = rgb2gray(I);
% Is = imresize(Ig, 0.2);
% [c, r] = imfindcircles(Is, [10 30], 'ObjectPolarity', 'dark');
% 
% % [centers, radii] = imfindcircles(I, [60 100]);
% 
% imshow(Is);
% viscircles(c, r,'EdgeColor','b');

for i=1:3
    subplot(1,3,i);
    imshow(readWithFlatField(sprintf('iphone_images/sample%d.jpg', i)));
end