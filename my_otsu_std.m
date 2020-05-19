%
%
%   **my_otsu_std演算法**
%
%   otsu 計算出來的門檻值 - 影像的 k 個標準差當作二值化的門檻值
%
%   參數說明
%   pic    要二值化的影像 (灰階)
%   k      幾個標準差？
%
%

function result = my_otsu_std(pic,k)
    Otsu_level = graythresh(pic);
    [row,col] = size(pic);
    pic_reshape = reshape(pic,[1,row*col]);
    pic_normal = double(pic_reshape)/256;
    pic_std = std(pic_normal);   % std()會返回每個row的標準差
    level = Otsu_level-(k*pic_std);
    result = im2bw(pic,level);
end
