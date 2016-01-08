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
refrad = 222.4149; % Constant from coin detection result.

% Extract region of interest.
cpos = [205.653469409500 533.119169418590];
crad = 130.089408348524; % Constants from coin detection.
regside = 2*crad;
roi = [cpos(1)-crad cpos(2)-crad regside regside];
%     [xmin ymin width height]
imgroi = imcrop(img, roi);
% Resize to fit the size of reference coin.
imgroi = imresize(imgroi, refrad/crad);

% Estimate transform by correlation.
tformEstimate = imregcorr(imgroi,imgref,'transformtype','rigid');

% Allign roi image.
Rimgref = imref2d(size(imgref)); % Reference object.
imgroiReg = imwarp(imgroi,tformEstimate,'OutputView',Rimgref);

% Show image pairs.
figure, imshowpair(imgref,imgroiReg,'falsecolor');

% Stopping timer.
disp('Full time:');
toc;