% coinRecComb.m
% Combined coin recognition with binary-approach radii estimation and
% circle detection based on those radii.
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
cszpx = cellfun(@length, cc.PixelIdxList).';
crpx  = sqrt(cszpx/pi);

% Find circles.
bndmul = 1.05; % Boundary size multiplier.
Rmin = round(min(crpx)/bndmul);
Rmax = round(max(crpx)*bndmul);
disp('Rmax < 3*Rmin?:');
disp([Rmax 3*Rmin]);
disp('(Rmax - Rmin) < 100?');
disp(Rmax - Rmin);
disp('Rmin > 10?');
disp(Rmin);
[centers, radii, metric] = imfindcircles(imgrgb,[Rmin Rmax],...
    'ObjectPolarity','dark','Sensitivity',0.985);

% Calculate diameters in mm using first estimates.
onerubd = 20.5;
sc1 = 2*crpx(1)/onerubd;
cdmm = 2*crpx/sc1;
disp('Coin diameters (first estimate):');
disp(cdmm);

% Calculate diameters in mm using final estimates.
[~, fstidx] = min(centers(:,1).^2 + centers(:,2).^2);
sc2 = 2*radii(fstidx)/onerubd;
cdmm2 = 2*radii/sc2;
disp('Coin diameters (second estimate):');
disp(cdmm2);

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