function newImg = histShape(srcimg, destimg)
% 1st Student: Coral Malachi, ID: 314882853
% 2md Student: Elisha Gerson, ID: 328612304

%The function get a gray-scale image as an argument and returns a gray-scale
%image obtained by applying the histogram shape algorithm on this image
newImg = srcimg;
[r_s,c_s] = size(srcimg);
[r_d,c_d]=size(destimg);

%build histogram for each image
hist1 = buildHist(srcimg);
hist2 = buildHist(destimg);

%build accumulate histogram for each histogram

accumulateHist1 = makeAccumulateHist(hist1);
accumulateHist2 = makeAccumulateHist(hist2);

NH1 = normalHistogram(accumulateHist1,r_s,c_s);
NH2 = normalHistogram(accumulateHist2,r_d,c_d);

%Get the conversion vector to map the new image
vec = buildConvertVector(NH1,NH2);

%map the new image according to the map (conversion vector)
for i = 1:r_s
    for j = 1:c_s
        newImg(i,j) = vec(srcimg(i,j)+1);
        
    end
    
end
end

function [hist] = buildHist(img)
%buildHist - Description
%This function get an image as an input
%and return its histogram
%

%save the size of the input image
[m,n] = size(img);

% the result hist - create a matrix of zeros of size 1x256
hist = zeros(1,256);

%for each colors in the image count the number of
%pixels in the image with that color
for i = 1:m
    for j = 1:n
        hist(img(i,j)+1) = hist(img(i,j)+1)+1;
    end
    
end
end


function [convertVector] = buildConvertVector(normalize_src_hist,normalize_dst_hist)
%buildConvertVector - Description
%This Method get as inputs 2 normalized histograms
%one of the source image and one of the target image and 
%return their conversion vector
src=1;
dst=1;
convertVector=zeros(1,256);
while src<=256
    if normalize_dst_hist(dst)<normalize_src_hist(src)
        dst=dst+1;
    else
        convertVector(src)=dst+1;
        src=src+1;
    end
end    
end

function noramlizedHist = normalHistogram(hist,r,c)
%normalHistogram - Description
%This method normalize the given histogram
noramlizedHist = hist/(r*c);
end

function accumulateHistogram = makeAccumulateHist(hist)
%makeAccumulateHist - Description
%
%copy the given histogram to output
accumulateHistogram=hist;
for gray_level = 2:256
    accumulateHistogram(gray_level)=hist(gray_level) + accumulateHistogram(gray_level-1);
    
end
end
