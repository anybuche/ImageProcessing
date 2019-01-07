% Project : Spanish greenhouses
% Version: November 28th, 2018
% Author(s): Anael Buchegger, David Sanchez del Rio

clc; clear all; close all;

%% Load the images
images = loadImages();
 
%% Bring out the greenhouses
close all;

% Subtract the two bands with the most difference
gh2013 = images.landsat2013(:,:,5)-images.landsat2013(:,:,7);
gh2018 = images.landsat2018(:,:,5)-images.landsat2018(:,:,7);

%Normalized indexes
gh2018n = (images.landsat2018(:,:,5)-images.landsat2018(:,:,7))./(images.landsat2018(:,:,5)+images.landsat2018(:,:,7));
gh2013n = (images.landsat2013(:,:,5)-images.landsat2013(:,:,7))./(images.landsat2013(:,:,5)+images.landsat2013(:,:,7));

figure('name', 'Greenhouses 2013')
imshow(gh2013)
figure('name', 'Greenhouses 2018')
imshow(gh2018)
% Histogram matching for better accuracy
gh2013m = imhistmatch(gh2013,gh2018);
landsatDiff = gh2018-gh2013m;
figure('name', 'Greenhouses difference')
imshow(landsatDiff);

figure('name', 'Greenhouses 2018 norm')
imshow(gh2018n);
figure('name', 'Greenhouses 2013 norm')
imshow(gh2013n);
% Histogram matching for better accuracy
gh2013nm = imhistmatch(gh2013n,gh2018n);
figure('name', 'Greenhouses difference norm')
imshow(gh2018n-gh2013nm);

%Thresholding
landsatDiff_uint8 = uint8(landsatDiff*255);
figure('name', 'Greenhouses difference 8bits')
imshow(landsatDiff_uint8)
landsatDiffth = landsatDiff_uint8>70; %This Threshold is to be adjusted
figure('name', 'Greenhouses difference thresholded')
imshow(landsatDiffth)

% Removing small artifacts by applying an opening filter
SE = strel('diamond',2); % 'diamond' 'square' %This size also has to be adjusted
% Performing Opening
landsatDiff_op = imopen(landsatDiffth,SE);
figure('name', 'Greenhouses difference thresholded and openend')
imshow(landsatDiff_op)

%% Kmeans algorithm
k = 6; %2 clusters
n_iter = 100;

%
landsatDiff_reshape = reshape(landsatDiff,size(landsatDiff,1)*size(landsatDiff,2),size(landsatDiff,3));

kmeansDiff = k_means(landsatDiff_reshape,k,n_iter);

figure('name', 'kmeans')
imagesc(reshape(kmeansDiff,size(landsatDiff,1),size(landsatDiff,2)));
title('k_means Diff');
axis equal tight

%% Kmeans algorithm
k = 4; %4 clusters
n_iter = 4;

% for 2013 and 2018 images
im2013_reshape = reshape(gh2013,size(gh2013,1)*size(gh2013,2),size(gh2013,3));
im2018_reshape = reshape(gh2018,size(gh2018,1)*size(gh2018,2),size(gh2018,3));

kmeans2013 = k_means(im2013_reshape,k,n_iter);
kmeans2018 = k_means(im2018_reshape,k,n_iter);

figure('name', 'kmeans')
subplot(121);
imagesc(reshape(kmeans2013,size(gh2013,1),size(gh2013,2)));
title('k_means 2013');
axis equal tight
xlabel('x')
ylabel('y')

subplot(122);
imagesc(reshape(kmeans2018,size(gh2018,1),size(gh2018,2)));
title('k_means 2018');
axis equal tight
xlabel('x')
ylabel('y')

%for nomalized images
im2013n_reshape = reshape(gh2013n,size(gh2013n,1)*size(gh2013n,2),size(gh2013n,3));
im2018n_reshape = reshape(gh2018n,size(gh2018n,1)*size(gh2018n,2),size(gh2018n,3));

kmeans2013 = k_means(im2013n_reshape,k,n_iter);
kmeans2018 = k_means(im2018n_reshape,k,n_iter);

figure('name', 'kmeans on normalized indexes')
subplot(121);
imagesc(reshape(kmeans2013,size(gh2013n,1),size(gh2013n,2)));
title('k_means 2013 normalized');
axis equal tight
xlabel('x')
ylabel('y')

subplot(122);
imagesc(reshape(kmeans2018,size(gh2018n,1),size(gh2018n,2)));
title('k_means 2018 normalized');
axis equal tight
xlabel('x')
ylabel('y')

% WORKS MUCH BETTER ON NORMALIZED PICTURES

%% Different filters

%trying low pass and high pass on gh2018n-gh2013n

% low pass (gaussian)
sigma = 2;
low_pass = fspecial('gaussian', 3, sigma); %3 for example
gh2013n_filtered = imfilter(gh2013n,low_pass);
gh2018n_filtered = imfilter(gh2018n,low_pass);

%high pass
sigma = 2;
high_pass = fspecial('log', 3, sigma); %3 for example
gh2013n_filtered2 = imfilter(gh2013n,high_pass);
gh2018n_filtered2 = imfilter(gh2018n,high_pass);


figure
subplot(311)
imshow(gh2013n_filtered)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('Low pass 2013')
subplot(312)
imshow(gh2013n_filtered2)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('High pass 2013')
subplot(313)
imshow(gh2013n)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('Not filtered 2013')

figure
subplot(311)
imshow(gh2018n_filtered)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('Low pass 2018')
subplot(312)
imshow(gh2018n_filtered2)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('High pass 2018')
subplot(313)
imshow(gh2018n)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('Not filtered 2018')

% TODO: essayer d'autres filtres matriciels avec fspecial3

%% Test de filtres

filter_average = [1 1 1;1 1 1;1 1 1];
filter_low_pass= [1 2 1;2 4 2;1 2 1];
filter_laplacian= [-1 -1 -1;-1 8 -1; -1 -1 -1];
reinforcement = [0 0 0;0 1 0; 0 0 0];
sobel_vert = [-1 0 1;-2 0 2;-1 0 1];
sobel_hor = [1 2 1; 0 0 0; -1 -2 -1];

open1 = imfilter(gh2013n, filter_average);
open2= imfilter(gh2013n, filter_low_pass);
open3 = imfilter(gh2013n, filter_laplacian);

figure
subplot(311)
imshow(open1)
subplot(312)
imshow(open2)
subplot(313)
imshow(open3)
 
%% Opening closing

SE = strel('disk',5); % 'diamond' 'square'

% Performing Opening
gh2013n_op = imopen(gh2013,SE);
%gh2018n_op = imopen(gh2018n,SE);
% Performing Closing
gh2013n_cl = imclose(gh2013,SE);
%gh2018n_cl = imclose(gh2018n,SE);

figure('name', 'Opening and Closing')
subplot(1,2,1);
imshow(gh2013n_op)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('2013 opening');

subplot(1,2,2);
imshow(gh2013n_cl)
axis equal tight
xlabel('easting [m]')
ylabel('northing [m]')
title('2013 closing');

% figure
% subplot(1,2,1);
% imshow(gh2018n_op)
% axis equal tight
% xlabel('easting [m]')
% ylabel('northing [m]')
% title('2018 opening');
% 
% subplot(1,2,2);
% imshow(gh2018n_cl)
% axis equal tight
% xlabel('easting [m]')
% ylabel('northing [m]')
% title('2018 closing');

%%%%%%% essayer avec d'autres types de SE









