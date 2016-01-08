% coinDet.m
% Utilizes MATLAB Image Processing Toolbox.

% Starting timer.
tic;

% Cleaning.
clear all;
close all;

% Load image.
imgrgb = imread('test_images/test_img1.jpg');
%imgrgb = imread('ref_images/Russia-Coin-1-1998-a.png');

% Find circles.
Rmin = 100;
Rmax = 150;
%Rmax = floor(min(size(imgrgb,1), size(imgrgb,2))/2);
%Rmin = floor(0.8*Rmax);
disp('Rmax < 3*Rmin?:');
disp([Rmax 3*Rmin]);
disp('(Rmax - Rmin) < 100?');
disp(Rmax - Rmin);
disp('Rmin > 10?');
disp(Rmin);
[centers, radii, metric] = imfindcircles(imgrgb,[Rmin Rmax],...
    'ObjectPolarity','dark','Sensitivity',0.985);

% Stopping timer before plotting.
disp('Time without plotting');
toc;

% Show original.
imshow(imgrgb);

% Visualize circles.
viscircles(centers, radii,'EdgeColor','b');

% Stopping timer.
disp('Full time:');
toc;