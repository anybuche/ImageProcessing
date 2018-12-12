% Project : Spanish greenhouses
% Version: November 28th, 2018
% Author(s): Anael Buchegger, David Sanchez del Rio

clc; clear all; close all;

%% read images

% LANDSAT 8 2013 10 07

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)

filepath{1} = 'Data/2013-10-07, Landsat 8 USGS, B01.tiff';
filepath{2} = 'Data/2013-10-07, Landsat 8 USGS, B02.tiff';
filepath{3} = 'Data/2013-10-07, Landsat 8 USGS, B03.tiff';
filepath{4} = 'Data/2013-10-07, Landsat 8 USGS, B04.tiff';
filepath{5} = 'Data/2013-10-07, Landsat 8 USGS, B05.tiff';
filepath{6} = 'Data/2013-10-07, Landsat 8 USGS, B06.tiff';
filepath{7} = 'Data/2013-10-07, Landsat 8 USGS, B07.tiff';
filepath{8} = 'Data/2013-10-07, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    landsat2013(:,:,i) = im2double(ima1);
end

% LANDSAT 8 2018 11 06

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)

filepath{1} = 'Data/2018-11-06, Landsat 8 USGS, B01.tiff';
filepath{2} = 'Data/2018-11-06, Landsat 8 USGS, B02.tiff';
filepath{3} = 'Data/2018-11-06, Landsat 8 USGS, B03.tiff';
filepath{4} = 'Data/2018-11-06, Landsat 8 USGS, B04.tiff';
filepath{5} = 'Data/2018-11-06, Landsat 8 USGS, B05.tiff';
filepath{6} = 'Data/2018-11-06, Landsat 8 USGS, B06.tiff';
filepath{7} = 'Data/2018-11-06, Landsat 8 USGS, B07.tiff';
filepath{8} = 'Data/2018-11-06, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    landsat2018(:,:,i) = im2double(ima1);
end
 
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




