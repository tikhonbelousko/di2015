clear all;
close all;
clc;

% Generating
X = 0:11;
Y1 = zeros(size(X));
Y1(6:8) = 4;

Y2 = zeros(size(X));
Y2(4:8) = 0:4;
Y2(9:end) = 4;

Y3 = zeros(size(X));
Y3(4) = 4;
Y3(9:10) = 4;

% Average
w = fspecial('average', [1 3]);
avg1 = imfilter(Y1,w);
avg2 = imfilter(Y2,w);
avg3 = imfilter(Y3,w);

% Median
med1 = medfilt1(Y1);
med2 = medfilt1(Y2);
med3 = medfilt1(Y3);

% Plotting
YS = {Y1, Y2, Y3, avg1, avg2, avg3, med1, med2, med3};

for i = 1:9;
    subplot(3, 3, i);
    plot(X, YS{i}, '.');
    axis([-1 12 -1 5]);
end