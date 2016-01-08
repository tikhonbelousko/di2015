% coinRec.m
% Utilizes MATLAB Image Processing Toolbox.

% Starting timer.
tic;

% Cleaning.
clear all;
close all;

% Load image.
%imgrgb = imread('test_images/test_img3.jpg');
imgrgb = imread('iphone_images/sample5.jpg');

% Convert to grayscale.
img = rgb2gray(imgrgb);

% Apply median filter.
img = medfilt2(img);

% Convert to binary image.
level = graythresh(img); % Uses Otsu's method.
imgbw = im2bw(img, level);

% Invert image for morphological operations.
imginv = imcomplement(imgbw);

% Morphological closing to get rid of holes in coins.
[h, w, c] = size(imgrgb);
szpar = sqrt(w*h);
dskrelszcl = 0.011;
dskszcl = round(dskrelszcl*szpar);
secl = strel('disk',dskszcl);
imgcl = imclose(imginv,secl);

% Morphological opening to get rid of noises.
dskszop = round(dskszcl*3);
seop = strel('disk',dskszop);
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
    'Closure', 'Opening', 'Labeled', 'Pseudo-colored'};

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