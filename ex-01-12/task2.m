clc;
clearvars;
close all;

I = imread('images/lena_color_256.tif');
h = size(I, 1);
w = size(I, 2);

% Original
subplot(2,3,1); 
imshow(I);
title('Original');
fprintf('SNR (Original) = %d\n', snr(I));

% Salt & pepper
I1 = I;
p = 0.05;
for i=1:h
    for j=1:w
        if  rand() < p
            if rand() > 0.5
                I1(i,j,:) = [0, 0, 0];
            else 
                I1(i,j,:) = [255, 255, 255];
            end
        end
    end
end

subplot(2,3,2); 
imshow(I1);
title('Salt & Pepper');
fprintf('SNR (Salt & Pepper) = %d\n', snr(I1));

% Normal noise
I2 = I;
normnoise = repmat(normrnd(0,10,w,h), [1,1,3]);
I2 = uint8((double(I) + normnoise));

subplot(2,3,3); 
imshow(I2);
title('Gaussian');
fprintf('Gaussian (Salt & Pepper) = %d\n', snr(I2));

% Salt pepper correction
subplot(2,3,5);
F1 = I1;
for i=1:3
    F1(:,:,i) = medfilt2(I1(:,:,i));
end
imshow(F1);
title('filtered');

% Gaussian correction
subplot(2,3,6);
F2 = I1;
for i=1:3
    avrg = fspecial('average', [3 3]);
    F2(:,:,i) = filter2(avrg, I2(:,:,i));
end
imshow(F2);
title('filtered');

