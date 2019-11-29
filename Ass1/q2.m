function nImg = q2(bigImage, smallImage)
% Student Name: Coral Malachi,ID: 314882853
%
%

% get size of small image:
[m_s,n_s] = size(smallImage);
% get size of big image:
[m_b,n_b] = size(bigImage);

% create the output image:
nImg = zeros(size(bigImage));

%  get number of tiles in each row
tiles_row = m_b/m_s;
%  get number of tiles in each col
tiles_col = n_b/n_s;

% start build the new image:
for i=1 : tiles_row:
    for j=1 : tiles_col:
        % cut the big image to non overlapping tiles with size equals to small image size
        tile_to_replace = bigImage( m_s*(i-1) + 1 : i*m_s , 1+(j-1)*n_s: j*n_s );
        % match the histogram of the small image to each of the tiles, by using histShape method
        % that was required for first task
        new_tile = histShape(smallImage,tile_to_replace);
        % replace the parts with the matched small image.
        nImg((i - 1) * m_s + 1 : i *m_s , (j - 1) * n_s + 1 : j * n_s) = new_tile;
    end
end

nImg = uint8(nImg);

end
