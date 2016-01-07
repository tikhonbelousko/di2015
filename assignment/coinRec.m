% coinRec.m
% Utilizes MATLAB Image Processing Toolbox.

% Cleaning.
clear all;
close all;

% Load image.
imgrgb = imread('test_images/test_img1.jpg');

% Convert to grayscale.
img = rgb2gray(imgrgb);

% Convert to binary image.
level = graythresh(img); % Uses Otsu's method.
imgbw = im2bw(img, level);

% Invert image for morphological operations.
imginv = imcomplement(imgbw);

% Morphological closing to get rid of holes in coins.
se = strel('disk',20);
imgcl = imclose(imginv,se);

% Morphological opening to get rid of noises.
imgop = imopen(imgcl,se);

% Labeling coins in the image.
cc = bwconncomp(imgop);
disp(cc);
imglbl = labelmatrix(cc);

% Converting to pseudo-colored image.
imgps = label2rgb(imglbl);

% Show images.
figure('name', 'Processing steps');
plotI = {imgrgb, img, imgbw, imginv, imgcl, imgop, imglbl, imgps};
titles = {'Original image', 'Grayscale', 'Binary', 'Inverted',...
    'Closure with 20px disk', 'Opening with 20px disk', 'Labeled',...
    'Pseudo-colored'};
subx = ceil(length(plotI)/2);
suby = 2;
for subi = 1:subx*suby;
    if subi <= length(titles)
        subplot(suby, subx, subi);
        imshow(plotI{subi});
        title(titles{subi});
    end
end