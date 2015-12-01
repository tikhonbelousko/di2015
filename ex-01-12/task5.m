clc;
clearvars;
close all;

I = imread('t014a.png');
h = size(I, 1);
w = size(I, 2);
% hist(double(I(:)), 20);

% Segmentation
t = graythresh(I);
BW = I;
BW = I < 255*t;

% Drawing
IMAGES = {I,BW};
for i=1:size(IMAGES,2)
    subplot(1,3,i)
    imshow(IMAGES{i});
end

% Experiments with regionprops
s = regionprops(BW,'centroid', 'Area');

centroids = cat(1, s.Centroid);
areas = cat(1, s.Area);
imax  = find(areas == max(areas));

subplot(1,3,3);
imshow(BW);
hold on
plot(centroids(imax,1),centroids(imax,2), 'rx')
hold off