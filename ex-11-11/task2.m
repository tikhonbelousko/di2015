clc;
clear all;

[I, map] = imread('kids.tif');
gs = rgb2gray(map);
hsv = rgb2hsv(map);

rmap = [map(:,1), zeros(256,1), zeros(256,1)];
gmap = [zeros(256, 1), map(:,2), zeros(256, 1)];
bmap = [zeros(256, 1), zeros(256, 1),  map(:,3)];

hmap = [hsv(:,1), zeros(256,1), zeros(256,1)];
smap = [zeros(256, 1), hsv(:,2), zeros(256, 1)];
vmap = [zeros(256, 1), zeros(256, 1),  hsv(:,3)];

% Original 
subplot(3,3,1), subimage(I, map);

% Gray scale
subplot(3,3,2), subimage(I, gs);

% RGB
subplot(3,3,4), subimage(I, rmap);
subplot(3,3,5), subimage(I, gmap);
subplot(3,3,6), subimage(I, bmap);

% HSV
subplot(3,3,7), subimage(I, hmap);
subplot(3,3,8), subimage(I, smap);
subplot(3,3,9), subimage(I, vmap);