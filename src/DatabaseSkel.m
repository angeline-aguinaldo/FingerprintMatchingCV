function [ bwSkel ] = DatabaseSkel ( im );

% fig = figure(1)
im = double(im(:,:,1))./256;
% imagesc(im); colormap('gray');

thresh = graythresh(im);
bw = im2bw(im, thresh);

bw = ~bw;

bw = medfilt2(bw);
% imagesc(bw); colormap('gray');

iter = 5;
j = 0;

while j < iter;
    bw = bwmorph(bw, 'skel');
    j = j + 1;
end

bw = bwmorph(bw, 'thin');
bw = bwmorph(bw, 'spur');
bw = bwmorph(bw, 'spur');
bw = bwmorph(bw,'bridge');
bwSkel = bwmorph(bw,'clean');

% imagesc(bwSkel); colormap('gray');

% close fig

end