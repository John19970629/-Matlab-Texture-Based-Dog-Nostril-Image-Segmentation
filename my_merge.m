%
%
%   �Ѽƻ���
%	pic1        �n�ĦX���v��A
%   pic2        �n�ĦX���v��B
%   r           gamma�Ѽƭ�
%	type        �ĦX�覡
%   reverse     �O�_�n�¥դϦV 1�G�¥լۤ�
%
%         �X�󥭧�  type = 1�G (A * B^r) ^ 1/(1+r)  range�G0<r  (�j�ռv�����t���a��)
%                   type = 2�G  A * (B^r)                    range�G0<r�@�@(�j�ռv�����G���a��)
%         ��ƥ���   type = 3�G (1-r)*A + r*B            range : 0~1����
%         �թM����  type = 4�G ( 2*A*B ) / (A+B)
%
%

function result = my_merge (pic1,pic2,r,type,reverse)

%     if (type==1) || (type==2) && (r<=0)
%         r = 0.1;
%         fprintf(1,'r had better more than 0.\ndefult: r=0.1\n');
%     end
%     
%     if (type==3) && (r<0) || (r>1)
%         r = 0.1;
%         fprintf(1,'r had better between 0 and 1.\ndefult: r=0.1\n');
%     end

    [row, col] = size(pic1);
    result = double (zeros(row,col));
    pic1 = double(pic1);    % �]���n������B��A�ҥH���A�n�Odouble
    pic2 = double(pic2);
    
    if reverse==1
        pic1 = 255-pic1;    % �]��correlation�Menergy�¥լۤϡA�ҥH�@�ӭn�¥��A��
    end

    switch type
        case 1
            for i = 1 : row
                for j = 1 : col
                    result(i,j) = (pic1(i,j) * (pic2(i,j)^r)) ^ (1/(1+r));
                end
            end
            
        case 2
            for i = 1 : row
                for j = 1 : col
                    result(i,j) = pic1(i,j) * (pic2(i,j)^r);
                end
            end
            
        case 3
            for i = 1 : row
                for j = 1 : col
                    result(i,j) = (1-r) * pic1(i,j) + r * pic2(i,j);
                end
            end
            
        case 4
            for i = 1 : row
                for j = 1 : col
                    result(i,j) = (2 * pic1(i,j) * pic2(i,j)) / ( pic1(i,j) +  pic2(i,j));
                end
            end
    end
            
    result = uint8(my_normalize(result,1));     %���W��0~255
   % imshow(result);
end