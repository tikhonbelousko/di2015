% coinRot.m
% Starting timer.
tic;

% Cleaning.
clear all;
close all;

% Load image.
imgrgb = imread('test_images/test_img1.jpg');

% Convert to grayscale.
img = rgb2gray(imgrgb);

% Load reference rub.
imgrefrgb = imread('ref_images/Russia-Coin-1-1998-a.png');

% Convert reference image to grayscale.
imgref = rgb2gray(imgrefrgb);

% Extract region of interest.
rside = 300;
roi = [70 370 rside rside]; % [xmin ymin width height]
imgroi = imcrop(img, roi);

% Detect features.
mt = 1000;
ptsref = detectSURFFeatures(imgref, 'MetricThreshold', mt);
ptsroi = detectSURFFeatures(imgroi, 'MetricThreshold', mt);

% Extract feature descriptors.
[ftref, vptref] = extractFeatures(imgref, ptsref);
[ftroi, vptroi] = extractFeatures(imgroi, ptsroi);

% Match features by using their descriptors.
idxpairs = matchFeatures(ftref, ftroi);

% Retrieve locations of corresponding points for each image.
mtchref = vptref(idxpairs(:,1));
mtchroi = vptroi(idxpairs(:,2));

% Show point matches. 
figure;
showMatchedFeatures(imgref,imgroi,mtchref,mtchroi);
title('Putatively matched points (including outliers)');

% Stopping timer before plotting.
disp('Time without plotting');
toc;

% Show images.
figure('name', 'Different images');
plotI = {imgref, imgroi};
titles = {'Reference', 'Region of interest'};
subx = ceil(length(plotI)/2);
suby = 2;
for subi = 1:subx*suby;
    if subi <= length(titles)
        subplot(suby, subx, subi);
        imshow(plotI{subi});
        title(titles{subi});
    end
end

% Stopping timer.
disp('Full time:');
toc;