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
bckbr = 0.7;
imgrefrgb = imread('ref_images/Russia-Coin-1-1998-a.png',...
    'BackgroundColor', [bckbr bckbr bckbr]);

% Convert reference image to grayscale.
imgref = rgb2gray(imgrefrgb);

% Extract region of interest.
rside = 300;
roi = [70 370 rside rside]; % [xmin ymin width height]
imgroi = imcrop(img, roi);

% Gradients.
[gmagref, gdirref] = imgradient(imgref,'Prewitt');
[gmagroi, gdirroi] = imgradient(imgroi,'Prewitt');

% Estimate transform by correlation.
tformEstimate = imregcorr(gmagroi,gmagref);

% Allign roi image.
Rgmagref = imref2d(size(gmagref)); % Reference object.
gmagroiReg = imwarp(gmagroi,tformEstimate,'OutputView',Rgmagref);

% Stopping timer before plotting.
disp('Time without plotting');
toc;

% Show image pairs.
figure, imshowpair(gmagref,gmagroiReg,'falsecolor');

% Stopping timer.
disp('Full time:');
toc;