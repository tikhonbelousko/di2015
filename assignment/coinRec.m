% coinRec.m
% Utilizes MATLAB Image Processing Toolbox.

% Starting timer.
tic;

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
secl = strel('disk',20);
imgcl = imclose(imginv,secl);

% Morphological opening to get rid of noises.
seop = strel('disk',60);
imgop = imopen(imgcl,seop);

% Labeling coins in the image.
cc = bwconncomp(imgop);
imglbl = labelmatrix(cc);

% Converting to pseudo-colored image.
imgps = label2rgb(imglbl);

% Extract coin sizes.
cszpx = cellfun(@length, cc.PixelIdxList);
onerubd = 20.5;
onerubar = pi*(onerubd/2)^2;
sc = cszpx(1)/onerubar; % Scale.
cszmm = cszpx/sc;
cdmm = 2*sqrt(cszmm/pi);
disp('Coin diameters:');
disp(cdmm);

% Stopping timer before plotting.
disp('Time without plotting');
toc;

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

% Stopping timer.
disp('Full time:');
toc;