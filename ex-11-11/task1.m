clc;
clear all;

[I, map] = imread('kids.tif');
J1 = imnoise(I, 'gaussian', 0.05, 0.0001);
J2 = imnoise(I, 'salt & pepper', 0.05);
J3 = imnoise(I, 'poisson');

figure, imshow(J1, map);
figure, imshow(J2, map);
figure, imshow(J3, map);