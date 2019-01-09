% Project : Spanish greenhouses
% Version: November 28th, 2018
% Author(s): Anael Buchegger, David Sanchez del Rio

clc; clear all; close all;

%% Load the images
images = loadImages();
 
%% Bring out the greenhouses
close all;

% Subtract the two bands with the most difference (Landsat)
gh2013 = images.landsat2013(:,:,5)-images.landsat2013(:,:,7);
gh2018 = images.landsat2018(:,:,5)-images.landsat2018(:,:,7);

% Bring out the difference for Landsat images
figure('name', 'Greenhouses 2013')
imshow(gh2013)
figure('name', 'Greenhouses 2018')
imshow(gh2018)

%% Histogram matching for better accuracy

gh2013m = imhistmatch(gh2013,gh2018);
landsatDiff = gh2018-gh2013m;
figure('name', 'Greenhouses difference 2013-2018')
imshow(landsatDiff);

%% Thresholding

landsatDiff_uint8 = uint8(landsatDiff*255);
landsatDiffth = landsatDiff_uint8 > 70; %This Threshold is to be adjusted
figure('name', 'Greenhouses difference thresholded')
imshow(landsatDiffth)

%% Removing small artifacts by applying an opening filter

SE = strel('diamond',2); %This size and shape also can be adjusted
% Performing Opening
landsatDiff_op = imopen(landsatDiffth,SE);
figure('name', 'Greenhouses difference thresholded and openend')
imshow(landsatDiff_op)

%% Estimate the number of new greenhouses

n = sum(sum(landsatDiff_op));
A = n*30*30/(100*100); %
A_tot = size(landsatDiff,1)*size(landsatDiff,2)*30*30/(100*100);
fprintf('Nombre de nouvelles hectares de serres: %d\n over %d total hectares\n', A, A_tot)

%% Kmeans algorithm on the difference between years

k = 3; %2 clusters
n_iter = 20;

landsatDiff_reshape = reshape(landsatDiff,size(landsatDiff,1)*size(landsatDiff,2),size(landsatDiff,3));

kmeansDiff = k_means(landsatDiff_reshape,k,n_iter);

figure('name', 'kmeans')
imagesc(reshape(kmeansDiff,size(landsatDiff,1),size(landsatDiff,2)));
title('k_means Diff');
axis equal tight

%% Kmeans algorithm on the 2013 full image

k = 5; %4 clusters
n_iter = 20;

im2013_reshape = reshape(images.landsat2013,size(images.landsat2013,1)*size(images.landsat2013,2),size(images.landsat2013,3));
kmeans2013 = k_means(im2013_reshape,k,n_iter);
figure('name', 'kmeans')
imagesc(reshape(kmeans2013,size(images.landsat2013,1),size(images.landsat2013,2)));
title('k_means 2013 smarter');
axis equal tight
xlabel('x')
ylabel('y')


%% Kmeans algorithm on the difference between bands in 2013 and 2018

k = 3; %4 clusters
n_iter = 20;

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
