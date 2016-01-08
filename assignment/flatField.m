% flatField.m
% Utilizes MATLAB Image Processing Toolbox.

% Cleaning.
clc; clearvars; close all;

I = imread('iphone_images/sample1.jpg');

% Init flat-field
F = double(imread('iphone_images/flat1.jpg'));
for i=2:5
    F = F + double(imread(sprintf('iphone_images/flat%d.jpg', i)));
end

% Calculate for each channel
FR = F(:,:,1);
FG = F(:,:,2);
FB = F(:,:,3);

FR_n = FR./mean(FR(:));
FG_n = FG./mean(FG(:));
FB_n = FB./mean(FB(:));

%%% Plot flat-field
% subplot(2,3,1); imshow(FR_n);
% subplot(2,3,2); imshow(FG_n);
% subplot(2,3,3); imshow(FB_n);

F_out = cat(3, FR_n, FG_n, FB_n);
I_out = uint8(double(I)./F_out);

subplot(1,2,1); imshow(I);
subplot(1,2,2); imshow(I_out);
