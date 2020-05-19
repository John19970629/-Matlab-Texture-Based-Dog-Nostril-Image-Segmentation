%
%
%   **my_otsu_std�t��k**
%
%   otsu �p��X�Ӫ����e�� - �v���� k �ӼзǮt��@�G�Ȥƪ����e��
%
%   �Ѽƻ���
%   pic    �n�G�Ȥƪ��v�� (�Ƕ�)
%   k      �X�ӼзǮt�H
%
%

function result = my_otsu_std(pic,k)
    Otsu_level = graythresh(pic);
    [row,col] = size(pic);
    pic_reshape = reshape(pic,[1,row*col]);
    pic_normal = double(pic_reshape)/256;
    pic_std = std(pic_normal);   % std()�|��^�C��row���зǮt
    level = Otsu_level-(k*pic_std);
    result = im2bw(pic,level);
end
