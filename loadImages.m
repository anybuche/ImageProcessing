function [images] = loadImages()
%LOADIMAGES Summary of this function goes here
%   Detailed explanation goes here

% LANDSAT 8 2013 10 07

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)
filepath{1} = '../Data/2013-10-07, Landsat 8 USGS, B01.tiff';
filepath{2} = '../Data/2013-10-07, Landsat 8 USGS, B02.tiff';
filepath{3} = '../Data/2013-10-07, Landsat 8 USGS, B03.tiff';
filepath{4} = '../Data/2013-10-07, Landsat 8 USGS, B04.tiff';
filepath{5} = '../Data/2013-10-07, Landsat 8 USGS, B05.tiff';
filepath{6} = '../Data/2013-10-07, Landsat 8 USGS, B06.tiff';
filepath{7} = '../Data/2013-10-07, Landsat 8 USGS, B07.tiff';
filepath{8} = '../Data/2013-10-07, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.landsat2013(:,:,i) = im2double(ima1);
end

% LANDSAT 8 2018 11 06

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)

filepath{1} = '../Data/2018-11-06, Landsat 8 USGS, B01.tiff';
filepath{2} = '../Data/2018-11-06, Landsat 8 USGS, B02.tiff';
filepath{3} = '../Data/2018-11-06, Landsat 8 USGS, B03.tiff';
filepath{4} = '../Data/2018-11-06, Landsat 8 USGS, B04.tiff';
filepath{5} = '../Data/2018-11-06, Landsat 8 USGS, B05.tiff';
filepath{6} = '../Data/2018-11-06, Landsat 8 USGS, B06.tiff';
filepath{7} = '../Data/2018-11-06, Landsat 8 USGS, B07.tiff';
filepath{8} = '../Data/2018-11-06, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.landsat2018(:,:,i) = im2double(ima1);
end

% LANDSAT 8 2018 11 06

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)

filepath{1} = '../Data/2018-11-06, Landsat 8 USGS, B01.tiff';
filepath{2} = '../Data/2018-11-06, Landsat 8 USGS, B02.tiff';
filepath{3} = '../Data/2018-11-06, Landsat 8 USGS, B03.tiff';
filepath{4} = '../Data/2018-11-06, Landsat 8 USGS, B04.tiff';
filepath{5} = '../Data/2018-11-06, Landsat 8 USGS, B05.tiff';
filepath{6} = '../Data/2018-11-06, Landsat 8 USGS, B06.tiff';
filepath{7} = '../Data/2018-11-06, Landsat 8 USGS, B07.tiff';
filepath{8} = '../Data/2018-11-06, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    landsat2018(:,:,i) = im2double(ima1);
end
end

