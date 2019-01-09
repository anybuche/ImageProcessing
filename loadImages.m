function [images] = loadImages()
% Load all images bands and store them inside images

%% Bigger images

% LANDSAT 8 2013 10 07

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)
% bands description: https://landsat.usgs.gov/what-are-band-designations-landsat-satellites
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

% Sentinel-2A L1C 2015 12 03

% read Sentinel 12 bands
% bands description: https://en.wikipedia.org/wiki/Sentinel-2
filepath{1} = '../Data/2015-12-03, Sentinel-2A L1C, B01.tiff';
filepath{2} = '../Data/2015-12-03, Sentinel-2A L1C, B02.tiff';
filepath{3} = '../Data/2015-12-03, Sentinel-2A L1C, B03.tiff';
filepath{4} = '../Data/2015-12-03, Sentinel-2A L1C, B04.tiff';
filepath{5} = '../Data/2015-12-03, Sentinel-2A L1C, B05.tiff';
filepath{6} = '../Data/2015-12-03, Sentinel-2A L1C, B06.tiff';
filepath{7} = '../Data/2015-12-03, Sentinel-2A L1C, B07.tiff';
filepath{8} = '../Data/2015-12-03, Sentinel-2A L1C, B08.tiff';
filepath{9} = '../Data/2015-12-03, Sentinel-2A L1C, B8A.tiff';
filepath{10} = '../Data/2015-12-03, Sentinel-2A L1C, B09.tiff';
filepath{11} = '../Data/2015-12-03, Sentinel-2A L1C, B11.tiff';
filepath{12} = '../Data/2015-12-03, Sentinel-2A L1C, B12.tiff';

for i = 1:12
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.sentinel2015(:,:,i) = im2double(ima1);
end

% Sentinel-2A L1C 2018 11 07

filepath{1} = '../Data/2018-11-07, Sentinel-2A L1C, B01.tiff';
filepath{2} = '../Data/2018-11-07, Sentinel-2A L1C, B02.tiff';
filepath{3} = '../Data/2018-11-07, Sentinel-2A L1C, B03.tiff';
filepath{4} = '../Data/2018-11-07, Sentinel-2A L1C, B04.tiff';
filepath{5} = '../Data/2018-11-07, Sentinel-2A L1C, B05.tiff';
filepath{6} = '../Data/2018-11-07, Sentinel-2A L1C, B06.tiff';
filepath{7} = '../Data/2018-11-07, Sentinel-2A L1C, B07.tiff';
filepath{8} = '../Data/2018-11-07, Sentinel-2A L1C, B08.tiff';
filepath{9} = '../Data/2018-11-07, Sentinel-2A L1C, B8A.tiff';
filepath{10} = '../Data/2018-11-07, Sentinel-2A L1C, B09.tiff';
filepath{11} = '../Data/2018-11-07, Sentinel-2A L1C, B11.tiff';
filepath{12} = '../Data/2018-11-07, Sentinel-2A L1C, B12.tiff';

for i = 1:12
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.sentinel2018(:,:,i) = im2double(ima1);
end

%% Smaller images


% LANDSAT 8 2013 10 07

% read Landsat 8 bands (12 bands, 1 to 9 multispectral 30m, 
% except 8 panchromatic at 15m, 10&11 TIR bands, 12 QA band)
% bands description: https://landsat.usgs.gov/what-are-band-designations-landsat-satellites
filepath{1} = '../Data/Small/2013-10-07, Landsat 8 USGS, B01.tiff';
filepath{2} = '../Data/Small/2013-10-07, Landsat 8 USGS, B02.tiff';
filepath{3} = '../Data/Small/2013-10-07, Landsat 8 USGS, B03.tiff';
filepath{4} = '../Data/Small/2013-10-07, Landsat 8 USGS, B04.tiff';
filepath{5} = '../Data/Small/2013-10-07, Landsat 8 USGS, B05.tiff';
filepath{6} = '../Data/Small/2013-10-07, Landsat 8 USGS, B06.tiff';
filepath{7} = '../Data/Small/2013-10-07, Landsat 8 USGS, B07.tiff';
filepath{8} = '../Data/Small/2013-10-07, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.landsat2013s(:,:,i) = im2double(ima1);
end

% LANDSAT 8 2018 11 06

filepath{1} = '../Data/Small/2018-11-06, Landsat 8 USGS, B01.tiff';
filepath{2} = '../Data/Small/2018-11-06, Landsat 8 USGS, B02.tiff';
filepath{3} = '../Data/Small/2018-11-06, Landsat 8 USGS, B03.tiff';
filepath{4} = '../Data/Small/2018-11-06, Landsat 8 USGS, B04.tiff';
filepath{5} = '../Data/Small/2018-11-06, Landsat 8 USGS, B05.tiff';
filepath{6} = '../Data/Small/2018-11-06, Landsat 8 USGS, B06.tiff';
filepath{7} = '../Data/Small/2018-11-06, Landsat 8 USGS, B07.tiff';
filepath{8} = '../Data/Small/2018-11-06, Landsat 8 USGS, B08.tiff';

for i = 1:8
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.landsat2018s(:,:,i) = im2double(ima1);
end

% Sentinel-2A L1C 2015 12 03

% read Sentinel 12 bands
% bands description: https://en.wikipedia.org/wiki/Sentinel-2
filepath{1} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B01.tiff';
filepath{2} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B02.tiff';
filepath{3} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B03.tiff';
filepath{4} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B04.tiff';
filepath{5} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B05.tiff';
filepath{6} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B06.tiff';
filepath{7} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B07.tiff';
filepath{8} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B08.tiff';
filepath{9} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B8A.tiff';
filepath{10} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B09.tiff';
filepath{11} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B11.tiff';
filepath{12} = '../Data/Small/2015-12-03, Sentinel-2A L1C, B12.tiff';

for i = 1:12
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.sentinel2015s(:,:,i) = im2double(ima1);
end

% Sentinel-2A L1C 2018 11 07

filepath{1} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B01.tiff';
filepath{2} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B02.tiff';
filepath{3} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B03.tiff';
filepath{4} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B04.tiff';
filepath{5} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B05.tiff';
filepath{6} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B06.tiff';
filepath{7} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B07.tiff';
filepath{8} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B08.tiff';
filepath{9} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B8A.tiff';
filepath{10} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B09.tiff';
filepath{11} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B11.tiff';
filepath{12} = '../Data/Small/2018-11-07, Sentinel-2A L1C, B12.tiff';

for i = 1:12
    [ima1, cmap1, refmat1, bbox1] = geotiffread(filepath{i});
    % To double
    images.sentinel2018s(:,:,i) = im2double(ima1);
end
end

