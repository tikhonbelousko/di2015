% coinRecComb.m
% Combined coin recognition with binary-approach radii estimation and
% circle detection based on those radii.
% Utilizes MATLAB Image Processing Toolbox.

% Starting timer.
tic;

% Cleaning.
clear all;
close all;

% Coins
% 0.01, 0.05, 0.10, 0.50, 1, 2, 5, 10
COINS = [15.50 18.50 17.50 19.50 20.50 23.00 25.00 22.00; ...
         00.01 00.05 00.10 00.50 01.00 02.00 05.00 10.00];
     
COLORS = ['y', 'm', 'c', 'r', 'g', 'b', 'w', 'k', ...
          'y', 'm', 'c', 'r', 'g', 'b', 'w', 'k'];

%==== Loading and preprocessing ====%

% Load image with preprocessing.
imgrgb = readWithFlatField('iphone_images/sample2.jpg');

%==== Rough diameter estimation ====%

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

% Extract coin sizes.
cszpx = cellfun(@length, cc.PixelIdxList).';
crpx  = sqrt(cszpx/pi);

% Calculate diameters in mm using first estimates.
onerubd = 20.5;
sc1 = 2*crpx(1)/onerubd;
cdmm = 2*crpx/sc1;
disp('Coin diameters (first estimate):');
disp(cdmm);

%==== Final diameter estimation ====%

% Find circles.
bndmul = 1.15; % Boundary size multiplier.
Rmin = round(min(crpx)/bndmul);
Rmax = round(max(crpx)*bndmul);
disp('Rmax < 3*Rmin?:');
disp([Rmax 3*Rmin]);
disp('(Rmax - Rmin) < 100?');
disp(Rmax - Rmin);
disp('Rmin > 10?');
disp(Rmin);
[centers, radii, metric] = imfindcircles(imgrgb,[Rmin Rmax],...
    'ObjectPolarity','dark','Sensitivity',0.93);

% Calculate diameters in mm using final estimates.
[~, fstidx] = min(centers(:,1).^2 + centers(:,2).^2);
sc2 = 2*radii(fstidx)/onerubd;
cdmm2 = 2*radii/sc2;
disp('Coin diameters (second estimate):');
disp(cdmm2);

%==== Plotting found circles ====%

% Show original.
imshow(imgrgb);

% Visualize circles.
viscircles(centers, radii,'EdgeColor','b');

sz = size(centers, 1)
for i=1:sz
    text(centers(i,1),centers(i,2), ...
        sprintf('%2.2f', cdmm2(i)),'Color',[1 1 0],'FontSize',20);
end
%==== Estimating money sum in the image ====%

% Total money sum
total_sum = 0;
for i=1:size(cdmm2,1)
    dif = abs(COINS(1,:) - cdmm2(i));
    [val, idx] = min(dif);
    if (val < 2)
        total_sum = total_sum + COINS(2,idx);
    end
end
disp(sprintf('Total sum: %10.1f\n', total_sum));

% Stopping timer.
disp('Full time:');
toc;