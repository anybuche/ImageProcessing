% Project : Spanish greenhouses
% Version: December 10th, 2018
% Author(s): Anael Buchegger, David Sanchez del Rio

clc; clear all; close all;

%% Load the images
images = loadImages();
 
%% Bring out the greenhouses (subtraction)

% Subtract the two bands with the most difference (Landsat)
gh2013 = images.landsat2013(:,:,5)-images.landsat2013(:,:,7);
gh2015 = images.landsat2015(:,:,5)-images.landsat2015(:,:,7);
gh2018 = images.landsat2018(:,:,5)-images.landsat2018(:,:,7);

gh2013_big = images.landsat2013_big(:,:,5)-images.landsat2013_big(:,:,7);
gh2018_big = images.landsat2018_big(:,:,5)-images.landsat2018_big(:,:,7);

% Subtract the two bands with the most difference (Sentinel)
% (Only for bigger images)
gh2015s_big = images.sentinel2015_big(:,:,7)-images.sentinel2015_big(:,:,12);
gh2018s_big = images.sentinel2018_big(:,:,7)-images.sentinel2018_big(:,:,12);

% Normalized index for Landsat bigger images
gh2013n = (images.landsat2013_big(:,:,5)-images.landsat2013_big(:,:,7))./...
          (images.landsat2013_big(:,:,5)+images.landsat2013_big(:,:,7));
gh2018n = (images.landsat2018_big(:,:,5)-images.landsat2018_big(:,:,7))./...
          (images.landsat2018_big(:,:,5)+images.landsat2018_big(:,:,7));

%% Displaying the difference for all images
% small images
figure('name', 'Landsat: Greenhouses 2013')
imshow(gh2013)
figure('name', 'Landsat: Greenhouses 2015')
imshow(gh2015)
figure('name', 'Landsat: Greenhouses 2018')
imshow(gh2018)

% big images
figure('name', 'Landsat: Greenhouses 2013, larger area')
imshow(gh2013_big)
figure('name', 'Landsat: Greenhouses 2018, larger area')
imshow(gh2018_big)

figure('name', 'Sentinel: Greenhouses 2015, larger area')
imshow(gh2015s_big)
figure('name', 'Sentinel: Greenhouses 2018, larger area')
imshow(gh2018s_big)

% normalized indexes
figure('name', 'Landsat: Greenhouses 2013, larger area, normalized index')
imshow(gh2013n)
figure('name', 'Landsat: Greenhouses 2018, larger area, normalized index')
imshow(gh2018n)

% From all these images, we decide to keep only the small ones, from
% Landsat 8

%% Histogram matching for better accuracy

% 2013-2018
gh2013m = imhistmatch(gh2013,gh2018);
landsatDiff1318 = gh2018-gh2013m;
figure('name', 'Greenhouses difference 2013-2018')
imshow(landsatDiff1318);

% 2015-2018
gh2015m = imhistmatch(gh2015,gh2018);
landsatDiff1518 = gh2018-gh2015m;
figure('name', 'Greenhouses difference 2015-2018')
imshow(landsatDiff1518);

%% (Matching illustration)
figure('name', 'Matching illustration')
subplot(131)
imshow(gh2015)
title('Greenhouses 2015');
subplot(132)
imshow(gh2015m)
title('Greenhouses 2015, matched');
subplot(133)
imshow(gh2018)
title('Greenhouses 2018');

%% Thresholding

% 2013-2018
landsatDiff1318_uint8 = uint8(landsatDiff1318*255);
landsatDiff1318th = landsatDiff1318_uint8 > 70; %This Threshold is to be adjusted
figure('name', 'Greenhouses difference thresholded, 13-18')
imshow(landsatDiff1318th)

% 2015-2018
landsatDiff1518_uint8 = uint8(landsatDiff1518*255);
landsatDiff1518th = landsatDiff1518_uint8 > 70; %This Threshold is to be adjusted
figure('name', 'Greenhouses difference thresholded, 15-18')
imshow(landsatDiff1518th)

%% Removing small artifacts by applying an opening filter

SE = strel('diamond',1); %This size and shape also can be adjusted

% Performing Opening, 2013-2018
landsatDiff1318_op = imopen(landsatDiff1318th,SE);
figure('name', 'Greenhouses difference thresholded and openend, 13-18')
imshow(landsatDiff1318_op)

% 2015-2018
landsatDiff1518_op = imopen(landsatDiff1518th,SE);
figure('name', 'Greenhouses difference thresholded and openend, 15-18')
imshow(landsatDiff1518_op)

%% (Change illustration)
figure('name', 'Change illustration')
subplot(221)
imshow(gh2013)
title('2013');
subplot(222)
imshow(gh2018)
title('2018');
subplot(223)
imshow(landsatDiff1318)
title('2018-2013');
subplot(224)
imshow(landsatDiff1318_op)
title('Extracted difference');

%% Estimate the number of new greenhouses

% Counting white pixels
n1318 = sum(sum(landsatDiff1318_op));
n1518 = sum(sum(landsatDiff1518_op));

% Area calculation, in hectares
A1318 = n1318*30*30/(100*100); %30x30m per pixel, given in hectares (100x100m)
A1518 = n1518*30*30/(100*100);

A_tot = size(landsatDiff1318,1)*size(landsatDiff1318,2)*30*30/(100*100);
fprintf(['Number of new greenhouses hectares between 2013 and 2018: %.0f,\n',...
         'between 2015 and 2018: %.0f,\nover %.0f total hectares\n'], A1318, A1518, A_tot)

%% Kmeans algorithm on the difference between years

k = 3; %2 clusters
n_iter = 20;

landsatDiff_reshape = reshape(landsatDiff1318,size(landsatDiff1318,1)...
                    *size(landsatDiff1318,2),size(landsatDiff1318,3));

kmeansDiff = k_means(landsatDiff_reshape,k,n_iter);

figure('name', 'kmeans, difference 2013-2018')
imagesc(reshape(kmeansDiff,size(landsatDiff1318,1),size(landsatDiff1318,2)));
title('k_means');
axis equal tight

%% Kmeans algorithm on the 2013 full image (8 bands)

k = 5; %4 clusters
n_iter = 20;

im2013_reshape = reshape(images.landsat2013,size(images.landsat2013,1)*size(images.landsat2013,2),size(images.landsat2013,3));
kmeans2013_all = k_means(im2013_reshape,k,n_iter);
figure('name', 'kmeans, all bands')
imagesc(reshape(kmeans2013_all,size(images.landsat2013,1),size(images.landsat2013,2)));
title('k_means 2013');
axis equal tight
xlabel('x')
ylabel('y')


%% Kmeans algorithm on the difference between bands, both in 2013 and 2018

k = 3; %4 clusters
n_iter = 20;

% for 2013 and 2018 images
im2013_reshape = reshape(gh2013,size(gh2013,1)*size(gh2013,2),size(gh2013,3));
im2018_reshape = reshape(gh2018,size(gh2018,1)*size(gh2018,2),size(gh2018,3));

kmeans2013 = k_means(im2013_reshape,k,n_iter);
kmeans2018 = k_means(im2018_reshape,k,n_iter);

figure('name', 'kmeans, difference between bands')
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

%% (K-means illustration)

figure('name', 'K-means illustration')
subplot(221)
imagesc(reshape(kmeans2013,size(gh2013,1),size(gh2013,2)));
title('2013');
axis equal tight
xlabel('x in pixels (30m)')
ylabel('y in pixels (30m)')

subplot(222)
imagesc(reshape(kmeans2018,size(gh2018,1),size(gh2018,2)));
title('2018');
axis equal tight
xlabel('x in pixels (30m)')
ylabel('y in pixels (30m)')

subplot(223)
imagesc(reshape(kmeans2013_all,size(images.landsat2013,1),size(images.landsat2013,2)));
title('2013, all bands');
axis equal tight
xlabel('x in pixels (30m)')
ylabel('y in pixels (30m)')

subplot(224)
imagesc(reshape(kmeansDiff,size(landsatDiff1318,1),size(landsatDiff1318,2)));
title('Extracted difference');
axis equal tight
xlabel('x in pixels (30m)')
ylabel('y in pixels (30m)')