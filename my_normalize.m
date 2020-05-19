%
%
%	**���W��**
%	�Ѽƻ���
%	pic1	�n���W�ƪ��Ƕ���
%	r       ����gamma��,r��1�Y�N�Ϥ���0~255
%
%
function result = my_normalize (pic1,r)
    this_pic1 = pic1;
    this_r = double(r);
    [row,lengths] = size(this_pic1);
    result = [row,lengths];
    result = uint8(result);
    tmp_Max=max(max(this_pic1));
    tmp_min=min(min(this_pic1));
    for i=1:row
        for j=1:lengths
            result(i,j) =  ((double(this_pic1(i,j)-tmp_min)/double(tmp_Max-tmp_min))^this_r)*255;
        end
    end
end