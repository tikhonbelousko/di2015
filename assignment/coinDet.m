% coinDet.m
% Utilizes MATLAB Image Processing Toolbox.

% Starting timer.
tic;

% Cleaning.
clear all;
close all;

% Load image.
imgrgb = imread('test_images/test_img3.jpg');

% Find circles.
Rmin = 100;
Rmax = 150;
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