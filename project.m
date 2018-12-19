% Project : Spanish greenhouses
% Version: November 28th, 2018
% Author(s): Anael Buchegger, David Sanchez del Rio

clc; clear all; close all;

images = loadImages();


 
%% Bring out the greenhouses
close all;

gh2013 = landsat2013(:,:,5)-landsat2013(:,:,7);
gh2018 = landsat2018(:,:,5)-landsat2018(:,:,7);
gh2018n = (landsat2018(:,:,5)-landsat2018(:,:,7))./(landsat2018(:,:,5)+landsat2018(:,:,7));
gh2013n = (landsat2013(:,:,5)-landsat2013(:,:,7))./(landsat2013(:,:,5)+landsat2013(:,:,7));

figure('name', 'Greenhouses 2013')
imshow(gh2013)
figure('name', 'Greenhouses 2018')
imshow(gh2018)
figure('name', 'Greenhouses difference')
imshow(gh2018-gh2013);
figure('name', 'Greenhouses 2018 norm')
imshow(gh2018n);
figure('name', 'Greenhouses 2013 norm')
imshow(gh2013n);
figure('name', 'Greenhouses difference norm')
imshow(gh2018n-gh2013n);

%%salut c david




