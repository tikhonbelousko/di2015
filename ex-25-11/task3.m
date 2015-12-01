clear all;
close all;
clc;

addpath('t044_images');


%%%
% Read data
%%%

% Source
I   = imread('cube.png');
I_c = imread('cube_corrupted.png');

% Bias
B(:,:,1) = imread('bias_1.png');
B(:,:,2) = imread('bias_2.png');
B(:,:,3) = imread('bias_3.png');

% Dark current
D(:,:,1) = imread('dark_1.png');
D(:,:,2) = imread('dark_2.png');
D(:,:,3) = imread('dark_3.png');

% Flatfield images.
F(:,:,1) = imread('flatfield_1.png');
F(:,:,2) = imread('flatfield_2.png');
F(:,:,3) = imread('flatfield_3.png');

%%%
% Solution
%%%
subplot(2,3,1); imshow(I_c); title('Corrupted');

% Bias
B_avg = mean(B, 3);
I_b = double(I_c) - B_avg;
D_b = double(D) - repmat(B_avg, [1 1 3]);
F_b = double(F) - repmat(B_avg, [1 1 3]);

subplot(2,3,2); imshow(uint8(I_b)); title('- Bias');

% Dark current
D_avg = mean(D_b, 3);
I_d = I_b - D_avg;
F_d = F_b - repmat(D_avg, [1 1 3]);
subplot(2,3,3); imshow(uint8(I_d)); title('- Dark current');

% Flat-field
F_sum = sum(F_d, 3);
F_n   = F_sum./mean(F_sum(:));
I_out = I_d./F_n;
subplot(2,3,4); imshow(uint8(I_d)); title('Flat-field norm');

% Original
subplot(2,3,5); imshow(I); title('Original');
