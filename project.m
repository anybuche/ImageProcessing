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

% Subtract the two bands with the most difference (Sentinel)
gh2015s = images.sentinel2015(:,:,7)-images.sentinel2015(:,:,12);
gh2018s = images.sentinel2018(:,:,7)-images.sentinel2018(:,:,12);

% Normalized indexes
gh2018n = (images.landsat2018(:,:,5)-images.landsat2018(:,:,7))./(images.landsat2018(:,:,5)+images.landsat2018(:,:,7));
gh2013n = (images.landsat2013(:,:,5)-images.landsat2013(:,:,7))./(images.landsat2013(:,:,5)+images.landsat2013(:,:,7));

% Bring out the difference for Landsat images
figure('name', 'Greenhouses 2013')
imshow(gh2013)
figure('name', 'Greenhouses 2018')
imshow(gh2018)
% Histogram matching for better accuracy
gh2013m = imhistmatch(gh2013,gh2018);
landsatDiff = gh2018-gh2013m;
figure('name', 'Greenhouses difference')
imshow(landsatDiff);

% Bring out the difference for Sentinel images
figure('name', 'Greenhouses 2013s')
imshow(gh2015s)
figure('name', 'Greenhouses 2018s')
imshow(gh2018s)
% Histogram matching for better accuracy
gh2015ms = imhistmatch(gh2015s,gh2018s);
sentinelDiff = gh2018s-gh2015ms;
figure('name', 'Greenhouses difference')
imshow(sentinelDiff);

figure('name', 'Greenhouses 2018 norm')
imshow(gh2018n);
figure('name', 'Greenhouses 2013 norm')
imshow(gh2013n);
% Histogram matching for better accuracy
gh2013nm = imhistmatch(gh2013n,gh2018n);
figure('name', 'Greenhouses difference norm')
imshow(gh2018n-gh2013nm);

%Thresholding (Landsat)
landsatDiff_uint8 = uint8(landsatDiff*255);
landsatDiffth = landsatDiff_uint8>70; %This Threshold is to be adjusted
figure('name', 'Greenhouses difference thresholded (Landsat)')
imshow(landsatDiffth)

%Thresholding (Sentinel)
sentinelDiff_uint8 = uint8(sentinelDiff*255);
sentinelDiffth = sentinelDiff_uint8>70; %This Threshold is to be adjusted
figure('name', 'Greenhouses difference thresholded (Sentinel)')
imshow(sentinelDiffth)

% Removing small artifacts by applying an opening filter
SE = strel('diamond',2); % 'diamond' 'square' %This size also has to be adjusted
% Performing Opening
landsatDiff_op = imopen(landsatDiffth,SE);
sentinelDiff_op = imopen(sentinelDiffth,SE);
figure('name', 'Greenhouses difference thresholded and openend (Landsat)')
imshow(landsatDiff_op)
figure('name', 'Greenhouses difference thresholded and openend (Sentinel)')
imshow(sentinelDiff_op)


%% Kmeans algorithm
k = 6; %2 clusters
n_iter = 100;

landsatDiff_reshape = reshape(landsatDiff,size(landsatDiff,1)*size(landsatDiff,2),size(landsatDiff,3));

kmeansDiff = k_means(landsatDiff_reshape,k,n_iter);

figure('name', 'kmeans')
imagesc(reshape(kmeansDiff,size(landsatDiff,1),size(landsatDiff,2)));
title('k_means Diff');
axis equal tight

%%
k = 4; %4 clusters
n_iter = 30;

im2013_reshape = reshape(images.landsat2013,size(images.landsat2013,1)*size(images.landsat2013,2),size(images.landsat2013,3));
kmeans2013 = k_means(im2013_reshape,k,n_iter);
figure('name', 'kmeans')
imagesc(reshape(kmeans2013,size(images.landsat2013,1),size(images.landsat2013,2)));
title('k_means 2013 smarter');
axis equal tight
xlabel('x')
ylabel('y')


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






