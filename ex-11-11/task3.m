clc;
clear all;

[I, map] = imread('kids.tif');
RGB = ind2rgb(I, map);
HSV = rgb2hsv(RGB);
ZEROS = zeros(size(I, 1), size(I, 2));
NOISE = 0.01;

% RGB
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

RN = imnoise(R, 'gaussian', 0, NOISE);
GN = imnoise(G, 'gaussian', 0, NOISE);
BN = imnoise(B, 'gaussian', 0, NOISE);

subplot(2,3,1); imshow(cat(3, RN, G, B));
subplot(2,3,2); imshow(cat(3, R, GN, B));
subplot(2,3,3); imshow(cat(3, R, G, BN));

% HSV
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

HN = imnoise(H, 'gaussian', 0, NOISE);
SN = imnoise(S, 'gaussian', 0, NOISE);
VN = imnoise(V, 'gaussian', 0, NOISE);

subplot(2,3,4); imshow(hsv2rgb(cat(3, HN, S, V)));
subplot(2,3,5); imshow(hsv2rgb(cat(3, H, SN, V)));
subplot(2,3,6); imshow(hsv2rgb(cat(3, H, S, VN)));
