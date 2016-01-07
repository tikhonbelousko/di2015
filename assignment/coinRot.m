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

% Estimate transform by correlation.
tformEstimate = imregcorr(imgroi,imgref);

% Allign roi image.
Rimgref = imref2d(size(imgref)); % Reference object.
imgroiReg = imwarp(imgroi,tformEstimate,'OutputView',Rimgref);

% Stopping timer before plotting.
disp('Time without plotting');
toc;

% Show image pairs.
figure, imshowpair(imgref,imgroiReg,'montage');
figure, imshowpair(imgref,imgroiReg,'falsecolor');

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