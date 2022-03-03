function iref = default_iref(data, psize)
% DEFAULT_IREF make an imref2d that's appropriate for a given dataset or window
%    DEFAULT_IREF(DATA, PSIZE) makes smallest imref2d that contains all the data,
%                               with pixels of size psize. The data may be formatted
%                               as standard stormprocess data or as an nx2 list of
%                               points.
%
%    DEFAULT_IREF(RANGE, PSIZE) sets the data range from the window
%                                   RANGE = [left right top bottom];

if isnumeric(data)
    if size(data) == [1 4] % user gave a window
        dtype = 'window';
    elseif size(data,2) == 2
        dtype = 'points';
        xs = data(:,1)';
        ys = data(:,2)';
    end
else
    dtype = 'points';
    xs = [data.x];
    ys = [data.y];
end

switch dtype
    case 'window'
        range = data;

        minx = range(1);
        miny = range(3);
        pwidth = ceil((range(2) - minx)/psize);
        pheight = ceil((range(4) - miny)/psize);
    case 'points'
        minx = min(xs);
        miny = min(ys);
        pwidth = ceil((max(xs) - minx)/psize);
        pheight = ceil((max(ys) - miny)/psize);
end

width = pwidth*psize;
height = pheight*psize;

xextent = minx + [0 width];
yextent = miny + [0 height];

iref = imref2d([pheight pwidth], xextent, yextent);
