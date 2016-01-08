function I_out = readWithFlatField(imgpath)
% Loads image and applies flat field from
% iphone_images folder

I = imread(imgpath);

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

F_out = cat(3, FR_n, FG_n, FB_n);
I_out = uint8(double(I)./F_out);
end
