%
%
%   參數說明
%	pic1        要融合的影像A
%   pic2        要融合的影像B
%   r           gamma參數值
%	type        融合方式
%   reverse     是否要黑白反向 1：黑白相反
%
%         幾何平均  type = 1： (A * B^r) ^ 1/(1+r)  range：0<r  (強調影像較暗的地方)
%                   type = 2：  A * (B^r)                    range：0<r　　(強調影像較亮的地方)
%         算數平均   type = 3： (1-r)*A + r*B            range : 0~1之間
%         調和平均  type = 4： ( 2*A*B ) / (A+B)
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
    pic1 = double(pic1);    % 因為要做次方運算，所以型態要是double
    pic2 = double(pic2);
    
    if reverse==1
        pic1 = 255-pic1;    % 因為correlation和energy黑白相反，所以一個要黑白顛倒
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
            
    result = uint8(my_normalize(result,1));     %正規化0~255
   % imshow(result);
end